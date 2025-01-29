import pytest

from src.add import add


def test_add_pos():
  assert add(1, 2) == 3

def test_add_neg():
  assert add(-1, -2) == -3


def test_add_mixed():
  assert add(-1, 2) == 1


@pytest.mark.parametrize("input1, input2, expected_value", [(1, 2, 3), (-1, -2, -3), (-1, 2, 1)])
def test_add(input1, input2, expected_value):
  assert add(input1, input2) == expected_value

