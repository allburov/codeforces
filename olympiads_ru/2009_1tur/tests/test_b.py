import time

import pytest

from b import office
from tests.common import get_tests

tests_, ids = get_tests('b')
MAX_TIME = 60


@pytest.mark.parametrize("in_, out_",
                         tests_, ids=ids
                         )
def test_this(in_, out_):
    in_ = [int(x) for x in in_.split(' ')]
    out_ = int(out_)
    ts = time.time()

    result = office(in_)

    te = time.time()
    duration = ts - te
    assert duration < MAX_TIME, "Spend too much time: {}>{}".format(duration, MAX_TIME)
    assert result == out_
