import time

import pytest

from a import position
from tests.common import get_tests

tests_, ids = get_tests('a')
MAX_TIME = 60


@pytest.mark.parametrize("in_, out_",
                         tests_, ids=ids
                         )
def test_a(in_, out_):
    in_ = int(in_)
    out_ = int(out_)
    ts = time.time()

    result = position(in_)

    te = time.time()
    duration = ts - te
    assert duration < MAX_TIME, "Spend too much time: {}>{}".format(duration, MAX_TIME)
    assert result == out_
