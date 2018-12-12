import os


def get_tests(name, one=False):
    files = os.listdir(name)
    tests_ = []
    ids = []
    for file_name in files:
        if file_name.endswith('.a'):
            continue
        file_name = str(file_name)

        in_name = os.path.join(name, file_name)
        out_name = os.path.join(name, file_name + ".a")

        with open(in_name, "r") as f:
            in_ = f.read().strip('\n')
        with open(out_name, "r") as f:
            out_ = f.read().strip('\n')

        tests_.append((in_, out_))
        ids.append(file_name)
        if one:
            break

    return tests_, ids
