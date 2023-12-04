from ..generators import LCGennerator  
import pytest

@pytest.fixture
def lc_generator_instance():
    return LCGennerator(x=1, n=10, a=5**5, m=2**13 - 1, c=3)

def test_find_period(lc_generator_instance):
    period = lc_generator_instance.find_period()
    assert period == 273 

def test_generate_sequence_length(lc_generator_instance):
    sequence = lc_generator_instance.generate_sequence()
    assert len(sequence) == 10  

def test_generate_sequence_values(lc_generator_instance):
    sequence = lc_generator_instance.generate_sequence()
    assert sequence == [3128, 3140, 7876, 6739, 317, 7708, 5963, 8044, 7515, 781]

