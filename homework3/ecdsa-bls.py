from ecdsa import SigningKey, SECP256k1
from hashlib import sha256
from py_ecc.bls import G2ProofOfPossession as bls
import time

my_private_key_hashed = sha256(b'MyPrivateKeyMilojeJoksimovic')
my_message = b"MyMessageMilojeJoksimovic"

def ecdsa_sign(priv_key = my_private_key_hashed, message = my_message):
    priv_key_ecdsa = SigningKey.from_string(my_private_key_hashed.digest(),curve=SECP256k1)
    signature = priv_key_ecdsa.sign(message)
    pub_key = priv_key_ecdsa.get_verifying_key()
    return signature,pub_key,message

def ecdsa_verify(pub_key,signature,message):
    return pub_key.verify(signature, message)

def bls_sign(priv_key = my_private_key_hashed, message = my_message):
    priv_key_bls = bls.KeyGen(my_private_key_hashed.digest())
    pub_key = bls.SkToPk(priv_key_bls)
    signature = bls.Sign(priv_key_bls, message)
    return signature,pub_key,message

def bls_verify(pub_key,signature,message):
    return bls.Verify(pub_key, message, signature)

start_time = time.time()
ecdsa_signature, ecdsa_pub_key, ecdsa_message = ecdsa_sign()
ecdsa_signing_time = time.time() - start_time

start_time = time.time()
ecdsa_verification = ecdsa_verify(ecdsa_pub_key,ecdsa_signature,ecdsa_message)
ecdsa_verification_time = time.time() - start_time

start_time = time.time()
bls_signature, bls_pub_key, bls_message = bls_sign()
bls_signing_time = time.time() - start_time

start_time = time.time()
bls_verification = bls_verify(bls_pub_key,bls_signature,bls_message)
bls_verification_time = time.time() - start_time

print(f"ECDSA Signing Time: {ecdsa_signing_time:.6f} seconds")
print(f"BLS Signing Time: {bls_signing_time:.6f} seconds")
print(f"ECDSA Verification Time: {ecdsa_verification_time:.6f} seconds")
print(f"BLS Verification Time: {bls_verification_time:.6f} seconds")