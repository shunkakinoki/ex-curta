import math
import random
from Crypto.Hash import keccak

# Bitcoin secp256k1 elliptic curve, private to public key conversion
# Fork of:
# https://github.com/wobine/blackboard101/blob/master/EllipticCurvesPart4-PrivateKeyToPublicKey.py
# Watch first !
# https://www.youtube.com/watch?v=iB3HcPgm_FI&list=LL&index=2&t=385s

# The proven prime
P = 115792089237316195423570985008687907853269984665640564039457584007908834671663
# Number of points in the field
N = 115792089237316195423570985008687907852837564279074904382605163141518161494337

# Generator point
Gx = 55066263022277343669578718895168534326250603453777594175500187360389116729240
Gy = 32670510020758816978083085130507043184471273380659243275938904335757337482424
G = (Gx, Gy)


def oncurve(p):  # Checks if point satifies x^3 +7 = y^2 , mod P
    x = p[0]
    y = p[1]
    x = (x*x*x+7) % P
    y = (y*y) % P
    return x == y


def modinv(a, n):  # Extended Euclidean Algorithm/"division" in elliptic curves
    lm = 1
    hm = 0
    low = a % n
    high = n
    while low > 1:
        ratio = high//low
        nm = hm-lm*ratio
        new = high-low*ratio
        high = low
        low = new
        hm = lm
        lm = nm
    return lm % n


def add(a, b):  # Not true addition, invented for EC. Could have been called anything.
    LamAdd = ((b[1]-a[1]) * modinv(b[0]-a[0], P)) % P
    x = (LamAdd*LamAdd-a[0]-b[0]) % P
    y = (LamAdd*(a[0]-x)-a[1]) % P
    return (x, y)


def inv(a):  # Inverses the y-coordinate
    return (a[0], P-a[1])


def sub(a, b):  # Subtraction by adding by the inverse
    return add(a, inv(b))


def double(a):  # This is called point doubling, also invented for EC.
    Lam = ((3*a[0]*a[0]) * modinv((2*a[1]), P)) % P
    x = (Lam*Lam-2*a[0]) % P
    y = (Lam*(a[0]-x)-a[1]) % P
    return (x, y)


def mult(GenPoint, ScalarHex):  # Double & add. Not true multiplication
    if ScalarHex == 0 or ScalarHex >= N:
        raise Exception("Invalid Scalar/Private Key")
    ScalarBin = str(bin(ScalarHex))[2:]
    Q = GenPoint
    for i in range(1, len(ScalarBin)):  # This is invented EC multiplication.
        Q = double(Q)  # print "DUB", Q[0]; print
        if ScalarBin[i] == "1":
            Q = add(Q, GenPoint)  # print "ADD", Q[0]; print
    return (Q)


def div(a, b):  # Point multiplication by multiplicative inverse, returns a point such that mult( div(a,b) , b ) == a
    # Curvepoints are "evenly divisible" by any scalar, there is no remainder
    return mult(a, modinv(b, N))


def half(a):  # Inverse of point doubling, same as div(a,2)
    return mult(a, 57896044618658097711785492504343953926418782139537452191302581570759080747169)


def set(a):
    return mult(G, a)


def xtoy(pk):  # gets y from x, uncomment if needed
    x = pk
    y_sq = (pow(x, 3, P) + 7) % P
    y = pow(y_sq, (P + 1) // 4, P)
    return y  # result may or may not need inversion


print("******* Public Key Generation *********")

privateKey = 1
publicKey = set(privateKey)

print(" G(x,y) * privatekey(scalar) == publicKey(x,y) ")
print("public key x = ", publicKey[0])
print("public key y = ", publicKey[1])
print("public key (x,y) is on curve", oncurve(publicKey))
print("***************************************")
print("publicKey / privatekey == G ", div(publicKey, privateKey) == G)

print("******* Signature Verification *********")


def sign(privateKey, message):
    while True:
        k = random.randint(1, N-1)
        x1, y1 = mult(G, k)
        r = x1 % N
        if r == 0:
            continue
        k_inv = modinv(k, N)
        kec = keccak.new(digest_bits=256)
        kec.update(message.encode('utf-8'))
        print("kec.digest() = ", kec.digest().hex())
        s = (k_inv * (int(kec.digest().hex(), 16) + privateKey * r)) % N
        if s != 0:
            break
    return r, s


# Example usage
message = "This is a test message"
r, s = sign(privateKey, message)

print("Signature (r, s):", hex(r), hex(s))

print("******* Break Signature Verification *********")


def break_sign(privateKey, message):
    while True:
        k = 2
        x1, y1 = mult(G, k)
        r = x1 % N
        if r == 0:
            continue
        k_inv = modinv(k, N)
        print(k_inv)
        kec = keccak.new(digest_bits=256)
        kec.update(message.encode('utf-8'))
        print("kec.digest() = ", kec.digest().hex())
        s = (k_inv * (int(kec.digest().hex(), 16) + privateKey * r)) % N
        if s != 0:
            break
    return r, s


# Example usage
message = "hello world"
r, s = break_sign(privateKey, message)

print("Break Signature (r, s):", hex(r), hex(s))


print("******* Solve Signature Verification *********")


def solve_sign(privateKey, message):
    while True:
        k = (N-1)//2
        x1, y1 = mult(G, k)
        r = x1 % N
        print("r = ", r)
        if r == 0:
            continue
        k_inv = modinv(k, N)
        print("k_inv = ", k_inv)
        kec = keccak.new(digest_bits=256)
        kec.update(message.encode('utf-8'))
        print("kec.digest() = ", kec.digest().hex())
        s = (k_inv * (int(kec.digest().hex(), 16) + privateKey * r)) % N
        if s != 0:
            break
    return r, s


message = "hello world"
r, s = solve_sign(privateKey, message)

print("Solve Signature (r, s):", hex(r), hex(s))

v = 28
r = 86918276961810349294276103416548851884759982251107
s = 22059676103201075954069675528621548851842367907118258858932254657270436085916
N = 115792089237316195423570985008687907852837564279074904382605163141518161494337
k = (N-1)//2
k_inv = 115792089237316195423570985008687907852837564279074904382605163141518161494335


# Calculate the modular inverse of k_inv
# k_inv_inv = pow(k_inv, -1, N)

# Substitute the given values and solve for h
# privateKey = 0  # Replace 0 with the actual privateKey value
# s = (k_inv * (h + privateKey * r)) % N
h = ((s * k) % N - (privateKey * r)) % N
print(h)
# print(115792089237316195423570985008687907852837564279074904382605163141518161494337 -1)
# s = (k_inv * (h + privateKey * r)) % N
# h = (s * k % N) - (privateKey * r)
# h = ((s % N) - (privateKey * r))

# print(h)
# s = (2 * (m + privateKey * r)) % N
# s = 2 * (z + r * priv)
# s * 2 = z + r * priv
# z = 1/2 * s - 1/2 * r * priv

# print("s -1 = ", inv)
# print("r*priv = ", mult(publicKey, r))
# print("z = ", sub(add(s, s), mult(publicKey, r)))
