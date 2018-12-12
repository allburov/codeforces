import time

import pytest

from d import metro as func
from tests.common import get_tests

tests_, ids = get_tests('d', one=True)
MAX_TIME = 60


@pytest.mark.parametrize("in_, out_",
                         tests_, ids=ids
                         )
def test_this(in_, out_):
    a, b, c = map(int, in_.split(' '))
    out_ = float(out_)
    ts = time.time()

    result = func(a, b, c)

    te = time.time()
    duration = te - ts
    assert duration < MAX_TIME, "Spend too much time: {}>{}".format(duration, MAX_TIME)
    assert result == out_
