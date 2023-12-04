# lib/assets/python/tests/test_md5.py
import pytest
from ..md5 import md5, md5_to_bytes

def test_md5_string():
    msg = "Hello, world!"
    result = md5(bytearray(msg, 'utf-8'))
    expected = "6cd3556deb0da54bca060b4c39479839"  
    assert result == expected

def test_md5_bytes():
    msg = b"Hello, world!"
    result = md5(bytearray(msg))
    expected = "6cd3556deb0da54bca060b4c39479839"  
    assert result == expected

def test_md5_to_bytes():
    msg = b"Hello, world!"
    result = md5_to_bytes(bytearray(msg))
    expected = b'l\xd3Um\xeb\r\xa5K\xca\x06\x0bL9G\x989'
    assert result == expected

