import json
import sys
from collections import defaultdict
from typing import Dict, List

sys.setrecursionlimit(1000000)


def read_input():
    solver = Solver()
    with open('./input.txt') as input_:
        n, m = tuple(map(int, input_.readline().split()))
        for _ in range(n):
            line = input_.readline()
            trigger_count, shipment_count, *fields = line.split()
            trigger_count = int(trigger_count)
            solver.subscribe(fields[:trigger_count], fields[trigger_count:])

        for _ in range(m):
            data = json.loads(input_.readline())
            solver.process(data)


# id
# price
# stock_count
# partner_content
#  title
#  description


def make_alike(offer: Dict, fields) -> Dict:
    result = {}
    for field in fields:
        if not field.startswith("partner_content."):
            value = offer.get(field, None)
            if not value:
                continue
            result[field] = value
            continue
        else:
            _, field = field.rsplit(".", maxsplit=1)
            pc = offer.get('partner_content', None)
            if not pc:
                continue
            value = pc.get(field, None)
            if not value:
                continue
            result.setdefault("partner_content", {})
            result['partner_content'][field] = value

    return result


def pc_field(field):
    if field == "title":
        return f"partner_content.{field}"
    if field == "description":
        return f"partner_content.{field}"
    return field


def to_pc(fields):
    return [pc_field(field) for field in fields]


class Solver:
    def __init__(self):
        self.db = defaultdict(dict)
        self.triggers = []

    def subscribe(self, triggers: List[str], shipment: List[str]):
        fields = set(shipment) | set(triggers) | {'id'}
        self.triggers.append((frozenset(to_pc(triggers)), to_pc(fields)))

    def process(self, event: Dict):
        instance, changed_fields = self._update(event['offer'])
        self._fire(instance, changed_fields, event['trace_id'])

    def _update(self, offer: Dict):
        changed_fields = set()
        id = offer['id']
        instance = self.db[id]
        instance['id'] = id

        for field in ('price', 'stock_count'):
            if field not in offer:
                continue
            if instance.get(field) != offer[field]:
                instance[field] = offer[field]
                changed_fields.add(field)

        if "partner_content" not in offer:
            return instance, changed_fields

        instance.setdefault("partner_content", {})
        instance_pc = instance['partner_content']
        offer_pc = offer['partner_content']

        for field in ('title', 'description'):
            if field not in offer_pc:
                continue
            if instance_pc.get(field) != offer_pc[field]:
                instance_pc[field] = offer_pc[field]
                changed_fields.add(pc_field(field))
                changed_fields.add("partner_content")

        return instance, changed_fields

    def _fire(self, offer: Dict, changed_fields, trace_id: str):
        if not changed_fields:
            return

        event = dict(trace_id=trace_id, offer=None)
        events = []
        for triggers, fields in self.triggers:
            if not (triggers & changed_fields):
                continue
            event_offer = make_alike(offer, fields)
            if event_offer in events:
                continue
            event['offer'] = event_offer
            print(json.dumps(event))
            events.append(event_offer)


def main():
    read_input()


if __name__ == "__main__":
    main()
