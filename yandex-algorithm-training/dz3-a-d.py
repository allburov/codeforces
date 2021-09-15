from collections import Counter
from collections import defaultdict


def read_input():
    with open('input.txt') as input_:
        n = int(input_.readline())
        scores = list(map(int, input_.readline().split()))
        nums = list(map(int, input_.readline().split()))
    return (scores, nums)


def task(scores, answers):
    n = len(scores)
    answers.append(0)
    assert len(answers) == n

    counter = Counter(answers)
    unique_answer_positions = {answer: pos for pos, answer in enumerate(answers[:-1]) if counter[answer] == 1}

    illbeat = defaultdict(int)

    for num in range(1, 102):
        counter[num] += 1
        answers[-1] = num

        was_unique_at = unique_answer_positions.pop(num, None)
        if counter[num] == 1:
            unique_answer_positions[num] = n-1

        if unique_answer_positions:
            winner_pos = unique_answer_positions[min(unique_answer_positions)]
        else:
            winner_pos = None

        if winner_pos is not None:
            scores[winner_pos] += answers[winner_pos]

        # Calculate how many enemies I'll beat
        for i in range(n):
            if scores[i] < scores[-1]:
                illbeat[num] += 1

        # Return results back
        unique_answer_positions.pop(num, None)
        if was_unique_at is not None:
            unique_answer_positions[num] = was_unique_at
        if winner_pos is not None:
            scores[winner_pos] -= answers[winner_pos]

        counter[num] -= 1

    if not illbeat:
        return 1

    max_illbeat = max(illbeat.values())
    for num, beat in illbeat.items():
        if beat == max_illbeat:
            return num


if __name__ == "__main__":
    args = read_input()
    res = task(*args)
    print(res)
