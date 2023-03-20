import { keccak_256 } from '@noble/hashes/sha3';
import { bytesToHex, hexToBytes as _hexToBytes } from '@noble/hashes/utils';
import { secp256k1 } from '@noble/curves/secp256k1';

export function add0x(hex: string) {
  return /^0x/i.test(hex) ? hex : `0x${hex}`;
}

export function strip0x(hex: string) {
  return hex.replace(/^0x/i, '');
}
export function hexToBytes(hex: string): Uint8Array {
  return _hexToBytes(strip0x(hex));
}

type Hex = string | Uint8Array;
type RSRec = { r: bigint; s: bigint; recovery?: number };
type SignOpts = { extraEntropy?: boolean };

const secp = {
  getPublicKey65b: (priv: Hex) => secp256k1.getPublicKey(priv, false),
  normalizePublicKeyTo65b: (pub: Hex) => secp256k1.ProjectivePoint.fromHex(pub).toRawBytes(false),
  sign: (msg: Hex, priv: Hex, opts?: SignOpts) => {
    return secp256k1.sign(msg, priv, {
      extraEntropy: opts?.extraEntropy === false ? undefined : true,
    });
  },
  signAsync: async (msg: Hex, priv: Hex, opts?: SignOpts): Promise<RSRec> => {
    return secp256k1.sign(msg, priv, {
      extraEntropy: opts?.extraEntropy === false ? undefined : true,
    });
  },
  sigRecoverPub: (rsrec: RSRec, msg: Hex, checkHighS = true) => {
    const sig = new secp256k1.Signature(rsrec.r, rsrec.s).addRecoveryBit(rsrec.recovery!);
    if (checkHighS && sig.hasHighS()) throw new Error('Invalid signature: s is invalid');
    return sig.recoverPublicKey(msg).toRawBytes();
  },
};

export const Address = {
  fromPrivateKey(key: string | Uint8Array): string {
    if (typeof key === 'string') key = hexToBytes(key);
    return Address.fromPublicKey(secp.getPublicKey65b(key));
  },

  fromPublicKey(key: string | Uint8Array): string {
    const pub = secp.normalizePublicKeyTo65b(key);
    const addr = bytesToHex(keccak_256(pub.subarray(1, 65))).slice(24);
    return Address.checksum(addr);
  },

  // ETH addr checksum is calculated by hashing the string with keccak.
  // NOTE: it hashes *string*, not a bytearray: keccak('beef') not keccak([0xbe, 0xef])
  checksum(nonChecksummedAddress: string): string {
    const addr = strip0x(nonChecksummedAddress.toLowerCase());
    if (addr.length !== 40) throw new Error('Invalid address, must have 40 chars');
    const hash = strip0x(bytesToHex(keccak_256(addr)));
    let checksummed = '';
    for (let i = 0; i < addr.length; i++) {
      // If ith character is 9 to f then make it uppercase
      const nth = Number.parseInt(hash[i], 16);
      let char = addr[i];
      if (nth > 7) char = char.toUpperCase();
      checksummed += char;
    }
    return add0x(checksummed);
  },

  verifyChecksum(address: string): boolean {
    const addr = strip0x(address);
    if (addr.length !== 40) throw new Error('Invalid address, must have 40 chars');
    if (addr === addr.toLowerCase() || addr === addr.toUpperCase()) return true;
    const hash = bytesToHex(keccak_256(addr.toLowerCase()));
    for (let i = 0; i < 40; i++) {
      // the nth letter should be uppercase if the nth digit of casemap is 1
      const nth = Number.parseInt(hash[i], 16);
      const char = addr[i];
      if (nth > 7 && char.toUpperCase() !== char) return false;
      if (nth <= 7 && char.toLowerCase() !== char) return false;
    }
    return true;
  },

  
  async sign(privateKey: string | Uint8Array, message: string, extraEntropy = false): Promise<bigint[]> {
    if (typeof privateKey === 'string') privateKey = strip0x(privateKey);
    const sig = await secp.signAsync(message, privateKey, { extraEntropy });
    return [sig.r, sig.s]
  }
};



export const main = async () => {
  const PRIVATE_KEY = "0x0000000000000000000000000000000000000000000000000000000000000001"
  const MESSAGE = "hello"
  const HASH_MESSAGE = bytesToHex(keccak_256(MESSAGE))

  const p = Address.fromPrivateKey(PRIVATE_KEY)
  const [r, s] = await Address.sign(PRIVATE_KEY, HASH_MESSAGE)
  console.log(p)

  console.log(add0x(r.toString(16)))
  console.log(add0x(s.toString(16)))
  console.log(add0x(HASH_MESSAGE))
};

main()