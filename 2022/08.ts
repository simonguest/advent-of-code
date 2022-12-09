import * as fs from "fs";

type Map = number[][];

const createMap = (data: string) => {
  return data.split("\n").map((row) => {
    return row.split("").map((c) => parseInt(c));
  });
};

const getLeftEdge = (map: Map, row: number, col: number) => {
  return map[row].slice(0, col);
};

const getRightEdge = (map: Map, row: number, col: number) => {
  return map[row].slice(col + 1, map[row].length);
};

const getUpEdge = (map: Map, row: number, col: number) => {
  let path = [];
  for (let r = row - 1; r >= 0; r--) {
    path.push(map[r][col]);
  }
  return path;
};

const getBottomEdge = (map: Map, row: number, col: number) => {
  let path = [];
  for (let r = row + 1; r <= map.length - 1; r++) {
    path.push(map[r][col]);
  }
  return path;
};

const getPathScore = (path: number[], treeHeight: number) => {
  let score = 0;
  for (const step of path) {
    if (step >= treeHeight) {
      score++;
      return score;
    }
    score++;
  }
  return score;
};

const getScenicScore = (map: Map, row: number, col: number) => {
  let leftScore = getPathScore(getLeftEdge(map, row, col).reverse(), map[row][col]);
  let rightScore = getPathScore(getRightEdge(map, row, col), map[row][col]);
  let upScore = getPathScore(getUpEdge(map, row, col), map[row][col]);
  let bottomScore = getPathScore(getBottomEdge(map, row, col), map[row][col]);
  return leftScore * rightScore * upScore * bottomScore;
};

const isVisible = (map: Map, row: number, col: number) => {
  if (row === 0 || row === map.length - 1) return true;
  if (col === 0 || col === map[0].length - 1) return true;
  if (getLeftEdge(map, row, col).sort((a, b) => b - a)[0] < map[row][col]) return true;
  if (getRightEdge(map, row, col).sort((a, b) => b - a)[0] < map[row][col]) return true;
  if (getUpEdge(map, row, col).sort((a, b) => b - a)[0] < map[row][col]) return true;
  if (getBottomEdge(map, row, col).sort((a, b) => b - a)[0] < map[row][col]) return true;
  return false;
};

const run = async (filename: string) => {
  const data = fs.readFileSync(filename, { encoding: "utf-8" });
  let map = createMap(data);
  let treesVisible = 0;
  let highestScenicScore = 0;
  for (let r = 0; r <= map[0].length - 1; r++) {
    for (let c = 0; c <= map.length - 1; c++) {
      if (isVisible(map, r, c)) {
        treesVisible += 1;
        let scenicScore = getScenicScore(map, r, c);
        if (scenicScore > highestScenicScore) highestScenicScore = scenicScore;
      }
    }
  }
  console.log(treesVisible);
  console.log(highestScenicScore);
};
run("08-data.txt");