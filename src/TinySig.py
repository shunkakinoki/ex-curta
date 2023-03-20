from ecdsa import SigningKey, VerifyingKey, SECP256k1
import hashlib

from fastecdsa import keys, curve, ecdsa

# generating the private key over secp224k1 curve
private_key = keys.gen_private_key(curve=curve.secp224k1)

# get the public key from the corresponding private key
public_key = keys.get_public_key(private_key, curve=curve.secp224k1)

msg = "Hello"

r, s = ecdsa.sign(msg, private_key, curve.secp224k1)

print(ecdsa.verify((r, s), msg, public_key, curve.secp224k1))


def sign_message(priv, r, k, message):
    sk = SigningKey.from_secret_exponent(priv, curve=SECP256k1)
    hash_message = hashlib.sha256(message.encode('utf-8')).hexdigest()
    print(hash_message)
    z = int(hash_message, 16)

    N = sk.curve.order
    inv_k = pow(k, -1, N)
    s = (inv_k * (z + r * priv)) % N

    return (r, s)


priv = 0x1
r = 86918276961810349294276103416548851884759982251107
k = 123456789
message = "Hello"


signature = sign_message(priv, r,  k, message)
print(f"Signature: {signature}")
