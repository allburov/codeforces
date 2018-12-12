import time

import pytest

from c import book
from tests.common import get_tests

tests_, ids = get_tests('c')
MAX_TIME = 60


@pytest.mark.parametrize("in_, out_",
                         tests_, ids=ids
                         )
def test_this(in_, out_):
    in_ = int(in_)
    out_ = int(out_)
    ts = time.time()

    result = book(in_)

    te = time.time()
    duration = te - ts
    assert duration < MAX_TIME, "Spend too much time: {}>{}".format(duration, MAX_TIME)
    assert result == out_
