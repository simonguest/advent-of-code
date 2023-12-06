time = 42899189
record = 308117012911467
beaten = 0


def calc_distance(button_press_time, time):
    speed = button_press_time
    return (time - button_press_time) * speed


for attempt in range(1, time):
    if (calc_distance(attempt, time) > record):
        beaten += 1

print(beaten)
