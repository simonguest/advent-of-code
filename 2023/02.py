import re


def parse_turns(turns_str):
    turns = []
    for turn_str in turns_str.split(';'):
        turn = []
        for block_str in turn_str.split(','):
            p = re.compile(r'(\d+) (\w+)')
            m = p.match(block_str.strip())
            if m:
                turn.append({
                    'number': int(m.group(1)),
                    'color': m.group(2)
                })
        turns.append(turn)
    return turns


def parse_game(game):
    p = re.compile(r'Game (\d+): (.*)')
    m = p.match(game)
    if m:
        return {
            'id': int(m.group(1)),
            'turns': parse_turns(m.group(2))
        }
    else:
        return None


def part_1(file):
    f = open(file, 'r')
    possible_game_id_total = 0
    for line in f:
        game = parse_game(line)
        possible = True
        for turn in game['turns']:
            for block in turn:
                if block['color'] == 'red' and block['number'] > 12:
                    possible = False
                if block['color'] == 'green' and block['number'] > 13:
                    possible = False
                if block['color'] == 'blue' and block['number'] > 14:
                    possible = False
        if possible:
            possible_game_id_total += game['id']
    return possible_game_id_total


def part_2(file):
    f = open(file, 'r')
    power = 0
    for line in f:
        game = parse_game(line)
        max_red, max_green, max_blue = 0, 0, 0
        for turn in game['turns']:
            for block in turn:
                if block['color'] == 'red':
                    max_red = max(max_red, block['number'])
                if block['color'] == 'green':
                    max_green = max(max_green, block['number'])
                if block['color'] == 'blue':
                    max_blue = max(max_blue, block['number'])
        power += max_red * max_green * max_blue
    return power


print(part_2('02-data.txt'))
