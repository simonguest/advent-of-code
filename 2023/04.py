import re

f = open('04-data.txt', 'r')
score = 0
for line in f.readlines():
    # pattern = r'Card (\d+):\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+\|\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)'
    pattern = r'Card\s+(\d+):\s+' + '\s+'.join([r'(\d+)'] * 10) + '\s+\|\s+' + '\s+'.join([r'(\d+)'] * 25)
    matches = re.finditer(pattern, line)
    for match in matches:
        groups = match.groups()
        card_id = int(groups[0])
        winning_numbers = [int(groups[i]) for i in range(1, 11)]
        card_numbers = [int(groups[i]) for i in range(11, 36)]
        matched_numbers = sum(1 for element in winning_numbers if element in card_numbers)
        if matched_numbers > 0:
            score += 2 ** (matched_numbers - 1)

print("Score:", score)
