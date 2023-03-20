package main

import (
	"bytes"
	"crypto/ecdsa"
	"crypto/rand"
	"fmt"
	"log"
	"math/big"

	"github.com/ethereum/go-ethereum/common/hexutil"
	"github.com/ethereum/go-ethereum/crypto"
	"golang.org/x/crypto/sha3"
)

// Ref: https://stackoverflow.com/questions/51111605/how-do-i-recover-ecdsa-public-key-correctly-from-hashed-message-and-signature-in

func main() {
	var _ bytes.Buffer
	var _ fmt.Formatter
	var _ = hexutil.Uint64(1)
	var _ = crypto.Keccak256Hash([]byte("hello"))

	privateKey, err := crypto.HexToECDSA("0000000000000000000000000000000000000000000000000000000000000001")
	if err != nil {
		log.Fatal(err)
	}

	fmt.Printf("Private Key: 0x%x\n", privateKey.D)

	// Derive the Ethereum address from the private key
	address := crypto.PubkeyToAddress(privateKey.PublicKey)
	fmt.Printf("Address: 0x%x\n", address)

	// Print the public key in hexadecimal format
	// publicKeyBytes := append(privateKey.PublicKey.X.Bytes(), privateKey.PublicKey.Y.Bytes()...)
	// publicKeyHex := hex.EncodeToString(publicKeyBytes)
	// fmt.Printf("Public Key: 0x%s\n", publicKeyHex)

	message := "Hello, world!"
	v := 27                    // Any desired value
	seedS := big.NewInt(12345) // Given seed value for 's'

	signature, err := customECDSASign(privateKey, []byte(message), v, seedS)
	if err != nil {
		panic(err)
	}

	fmt.Printf("Signature: (V: %d, R: %x, S: %x)\n", signature.V, signature.R, signature.S)
}

type CustomSignature struct {
	V    int
	R, S *big.Int
}

func customECDSASign(privateKey *ecdsa.PrivateKey, message []byte, v int, seedS *big.Int) (*CustomSignature, error) {
	curve := privateKey.Curve
	n := curve.Params().N

	hash := sha3.NewLegacyKeccak256()
	hash.Write(message)
	digest := hash.Sum(nil)

	z := new(big.Int).SetBytes(digest)
	z = z.Mod(z, n)

	var r, kInv, d *big.Int

	for {
		k, err := rand.Int(rand.Reader, n)
		if err != nil {
			return nil, err
		}

		x1, _ := curve.ScalarBaseMult(k.Bytes())
		r = x1.Mod(x1, n)

		if r.Cmp(new(big.Int).Exp(big.NewInt(2), big.NewInt(128), nil)) >= 0 {
			continue
		}

		kInv = new(big.Int).ModInverse(k, n)
		if kInv == nil {
			continue
		}

		d = new(big.Int).Sub(new(big.Int).Mul(seedS, r), z)
		d = d.Mul(d, kInv).Mod(d, n)
		break
	}

	return &CustomSignature{
		V: v,
		R: r,
		S: seedS,
	}, nil
}
