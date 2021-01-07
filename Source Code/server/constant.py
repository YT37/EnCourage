alpha = {
    "a": [1, 0, 0, 0, 0, 0],
    "b": [1, 1, 0, 0, 0, 0],
    "c": [1, 0, 0, 1, 0, 0],
    "d": [1, 0, 0, 1, 1, 0],
    "e": [1, 0, 0, 0, 1, 0],
    "f": [1, 1, 0, 1, 0, 0],
    "g": [1, 1, 0, 1, 1, 0],
    "h": [1, 1, 0, 0, 1, 0],
    "i": [0, 1, 0, 1, 0, 0],
    "j": [0, 1, 0, 1, 1, 0],
    "k": [1, 0, 1, 0, 0, 0],
    "l": [1, 1, 1, 0, 0, 0],
    "m": [1, 0, 1, 1, 0, 0],
    "n": [1, 0, 1, 1, 1, 0],
    "o": [1, 0, 1, 0, 1, 0],
    "p": [1, 1, 1, 1, 0, 0],
    "q": [1, 1, 1, 1, 1, 0],
    "r": [1, 1, 1, 0, 1, 0],
    "s": [0, 1, 1, 1, 0, 0],
    "t": [0, 1, 1, 1, 1, 0],
    "u": [1, 0, 1, 0, 0, 1],
    "v": [1, 1, 1, 0, 0, 1],
    "w": [0, 1, 0, 1, 1, 1],
    "x": [1, 0, 1, 1, 0, 1],
    "y": [1, 0, 1, 1, 1, 1],
    "z": [1, 0, 1, 0, 1, 1],
}

words = {
    "but": alpha["b"],
    "can": alpha["c"],
    "do": alpha["d"],
    "every": alpha["e"],
    "from": alpha["f"],
    "go": alpha["g"],
    "have": alpha["h"],
    "just": alpha["j"],
    "knowledge": alpha["k"],
    "like": alpha["l"],
    "more": alpha["m"],
    "not": alpha["n"],
    "people": alpha["p"],
    "quite": alpha["q"],
    "rather": alpha["r"],
    "so": alpha["s"],
    "that": alpha["t"],
    "us": alpha["u"],
    "very": alpha["v"],
    "will": alpha["w"],
    "it": alpha["x"],
    "you": alpha["y"],
    "as": alpha["z"],
    "and": [1, 1, 1, 1, 0, 1],
    "of": [1, 1, 1, 0, 1, 1],
    "the": [0, 1, 1, 1, 0, 1],
    "with": [0, 1, 1, 1, 1, 1],
    "child": [1, 0, 0, 0, 0, 0],
    "shall": [1, 0, 0, 1, 0, 1],
    "this": [1, 0, 0, 1, 1, 1],
    "which": [1, 0, 0, 0, 1, 1],
    "out": [1, 1, 0, 0, 1, 1],
    "for": [1, 1, 1, 1, 1, 1],
    "was": [0, 0, 1, 0, 1, 1],
    "enough": [0, 1, 0, 0, 0, 1],
    "still": [0, 0, 1, 1, 0, 0],
    "his": [0, 1, 1, 0, 0, 1],
    "were": [0, 1, 1, 0, 1, 1],
    "by": [0, 0, 1, 0, 1, 1],
    "to": [0, 1, 1, 0, 1, 0],
    "be": [0, 1, 1, 0, 0, 0],
}

sounds = {
    "with": [0, 1, 1, 1, 1, 1],
    "con": words["can"],
    "dis": [0, 1, 0, 0, 1, 1],
    "ing": [0, 0, 1, 1, 0, 1],
    "the": [0, 1, 1, 1, 0, 1],
    "ble": [0, 0, 1, 1, 1, 1],
    "for": [1, 1, 1, 1, 1, 1],
    "and": [1, 1, 1, 1, 0, 1],
    "com": [0, 0, 1, 0, 0, 1],
    "ch": words["child"],
    "gh": [1, 1, 0, 0, 0, 1],
    "of": [1, 1, 1, 0, 1, 1],
    "ff": [0, 1, 1, 0, 1, 0],
    "gg": [0, 1, 1, 0, 1, 1],
    "sh": words["shall"],
    "th": words["this"],
    "wh": words["which"],
    "ed": [1, 1, 0, 1, 0, 1],
    "er": [1, 1, 0, 1, 1, 1],
    "ou": words["out"],
    "ow": [0, 1, 0, 1, 0, 1],
    "bb": [0, 1, 1, 0, 0, 0],
    "cc": words["can"],
    "dd": [0, 1, 0, 0, 1, 1],
    "en": [0, 1, 0, 0, 0, 1],
    "gg": words["were"],
    "in": [0, 0, 1, 0, 1, 0],
    "st": [0, 0, 1, 1, 0, 0],
    "ar": [0, 0, 1, 1, 1, 0],
    "be": [0, 1, 1, 0, 0, 0],
    "ea": [0, 1, 0, 0, 0, 0],
    "to": [0, 1, 1, 0, 1, 0],
    "by": [0, 0, 1, 0, 1, 1],
}

nums = {
    "1": alpha["a"],
    "2": alpha["b"],
    "3": alpha["c"],
    "4": alpha["d"],
    "5": alpha["e"],
    "6": alpha["f"],
    "7": alpha["g"],
    "8": alpha["h"],
    "9": alpha["i"],
    "0": alpha["j"],
}

punct = {
    ".": [0, 1, 0, 0, 1, 1],
    ",": [0, 1, 0, 0, 0, 0],
    ";": [0, 1, 1, 0, 0, 0],
    ":": [0, 1, 0, 0, 1, 0],
    "'": [0, 0, 1, 0, 0, 0],
    "?": [0, 1, 1, 0, 0, 1],
    "!": [0, 1, 1, 0, 1, 0],
    "(": [0, 1, 1, 0, 1, 1],
    ")": [0, 1, 1, 0, 1, 1],
    "“": [0, 1, 1, 0, 0, 1],
    "”": [0, 0, 1, 0, 1, 1],
}

