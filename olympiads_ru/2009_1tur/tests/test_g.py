import time

import pytest

from g import main
from tests.common import get_tests

tests_, ids = get_tests('g')
MAX_TIME = 60


@pytest.mark.parametrize("in_, out_",
                         tests_, ids=ids
                         )
def test_this(in_, out_):
    ts = time.time()

    result = main(in_)

    te = time.time()
    duration = te - ts
    assert duration < MAX_TIME, "Spend too much time: {}>{}".format(duration, MAX_TIME)
    assert result == out_
