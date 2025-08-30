from urllib.parse import urlencode
from base64 import b64encode

from Cryptodome.Signature import pkcs1_15
from Cryptodome.Hash import SHA256
from Cryptodome.PublicKey import RSA

def sign(params, private_key_path):
    query = urlencode(sorted(params.items()))
    with open(private_key_path, "rb") as f:
        private_key = RSA.import_key(f.read())
    h = SHA256.new(query.encode())
    signature = pkcs1_15.new(private_key).sign(h)
    return b64encode(signature).decode()

