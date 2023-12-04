import pytest
from unittest.mock import patch
from ..rc5 import encode, decode

def test_encode():
    key = "secret_key"
    data = b"example_data"
    with patch("base64.b64encode", return_value=b"mocked_base64_output"):
        result = encode(key, data)

    assert result == "mocked_base64_output"
    

def test_decode():
    key = "secret_key"
    enc = "8qzDSsa/pY+REXxWR/LvXw=="
    result = decode(key, enc)
    assert result == b'example_data\n'