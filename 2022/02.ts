import * as fs from "fs";
import { parse } from "csv-parse";

enum Move {
  Rock = "A",
  Paper = "B",
  Scissors = "C",
}

enum Outcome {
  Win,
  Lose,
  Draw,
}

type Round = {
  oppMove: Move;
  myMove: Move;
};

const getValueOfMove = (move: Move) => {
  switch (move) {
    case Move.Rock:
      return 1;
    case Move.Paper:
      return 2;
    case Move.Scissors:
      return 3;
  }
};

const getOutcome = (round: Round) => {
  if (round.myMove === round.oppMove) return Outcome.Draw;
  switch (round.myMove) {
    case Move.Rock:
      return round.oppMove === Move.Scissors ? Outcome.Win : Outcome.Lose;
    case Move.Paper:
      return round.oppMove === Move.Scissors ? Outcome.Lose : Outcome.Win;
    case Move.Scissors:
      return round.oppMove === Move.Rock ? Outcome.Lose : Outcome.Win;
  }
};

const calculateScore = (round: Round) => {
  switch (getOutcome(round)) {
    case Outcome.Win:
      return getValueOfMove(round.myMove) + 6;
    case Outcome.Draw:
      return getValueOfMove(round.myMove) + 3;
    case Outcome.Lose:
      return getValueOfMove(round.myMove);
  }
};

const run = async () => {
  const data = fs.readFileSync("02-data.csv", { encoding: "utf-8" });
  parse(
    data,
    {
      delimiter: " ",
      columns: ["oppMove", "myMove"],
      cast: (val, ctx) => {
        if (ctx.column === "myMove") {
          switch (val) {
            case "X":
              return "A";
            case "Y":
              return "B";
            case "Z":
              return "C";
          }
        }
        return val;
      },
    },
    (error, rounds: Round[]) => {
      if (error) console.error(error);
      let total = 0;
      rounds.forEach((r) => {
        total += calculateScore(r);
      });
      console.log(total);
    }
  );
};

const run2 = async () => {
  const data = fs.readFileSync("02-data.csv", { encoding: "utf-8" });
  parse(
    data,
    {
      delimiter: " ",
      columns: ["oppMove", "myMove"],
    },
    (error, rounds: Round[]) => {
      if (error) console.error(error);
      let total = 0;
      rounds = rounds.map((r) => {
        switch (r.myMove.toString()) {
          case "X": {
            if (r.oppMove === Move.Rock) r.myMove = Move.Scissors;
            if (r.oppMove === Move.Paper) r.myMove = Move.Rock;
            if (r.oppMove === Move.Scissors) r.myMove = Move.Paper;
            break;
          }
          case "Y": {
            r.myMove = r.oppMove;
            break;
          }
          case "Z": {
            if (r.oppMove === Move.Rock) r.myMove = Move.Paper;
            if (r.oppMove === Move.Paper) r.myMove = Move.Scissors;
            if (r.oppMove === Move.Scissors) r.myMove = Move.Rock;
            break;
          }
        }
        return r;
      });
      rounds.forEach((r) => {
        total += calculateScore(r);
      });
      console.log(total);
    }
  );
};
run2();
