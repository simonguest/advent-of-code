import * as fs from "fs";

type File = {
  name: string;
  bytes: number;
};

type Node = {
  name: string;
  subdirectories: Node[];
  files: File[];
  folderSize: number;
};

type Command = {
  instruction: string;
  param: string;
};

type Listing = {
  dir: boolean;
  bytes?: number;
  name: string;
};

const parseCommand = (command: string) => {
  let tokens = command.split(" ");
  return { instruction: tokens[1], param: tokens[2] };
};

const parseListing = (line: string) => {
  let tokens = line.split(" ");
  if (tokens[0] === "dir") {
    return { dir: true, name: tokens[1] };
  }
  return { dir: false, bytes: parseInt(tokens[0]), name: tokens[1] };
};

const mkdir = (node: Node, path: string, name: string) => {
  let parts = path.split("/").filter((p) => p !== "");
  if (parts.length === 0) {
    node.subdirectories.push({ name: name, subdirectories: [], files: [], folderSize: 0 });
    return node;
  } else {
    mkdir(
      node.subdirectories.find((s) => s.name === parts[0]),
      "/" + parts.slice(1, parts.length).join("/"),
      name
    );
  }
  return node;
};

const addFile = (node: Node, path: string, file: File) => {
  let parts = path.split("/").filter((p) => p !== "");
  if (parts.length === 0) {
    node.files.push(file);
    node.folderSize = node.folderSize ? node.folderSize + file.bytes : file.bytes;
    return node;
  } else {
    addFile(
      node.subdirectories.find((s) => s.name === parts[0]),
      "/" + parts.slice(1, parts.length).join("/"),
      file
    );
  }
  return node;
};

const getFolderSizes = (node: Node, names: any[] = []) => {
  node.subdirectories.forEach((s) => getFolderSizes(s, names));
  node.folderSize += node.subdirectories
    .map((s) => s.folderSize)
    .filter((f) => f !== undefined)
    .reduce((s, a) => s + a, 0);
  names.push({ name: node.name, folderSize: node.folderSize });
  return names;
};

const run = async (filename: string) => {
  let filesystem: Node = { name: "", subdirectories: [], files: [], folderSize: 0 };
  let cwd = "/";
  const data = fs.readFileSync(filename, { encoding: "utf-8" });
  const lines = data.split("\n");
  lines.forEach((l) => {
    if (l.startsWith("$")) {
      let cmd: Command = parseCommand(l);
      switch (cmd.instruction) {
        case "cd":
          if (cmd.param === "/") break;
          if (cmd.param === "..") {
            let parts = cwd.split("/").filter((f) => f);
            cwd = parts.length === 1 ? "" : "/" + parts.slice(0, parts.length - 1).join("/");
          } else {
            cwd += cmd.param;
          }
          cwd += "/";
          break;
      }
    } else {
      let listing: Listing = parseListing(l);
      if (listing.dir === true) {
        filesystem = mkdir(filesystem, cwd, listing.name);
      } else {
        filesystem = addFile(filesystem, cwd, { name: listing.name, bytes: listing.bytes });
      }
    }
  });
  
  let folderSizes = getFolderSizes(filesystem);
  console.log(
    folderSizes
      .map((f) => f.folderSize)
      .filter((s) => s < 100000)
      .reduce((s, a) => s + a, 0)
  );

  const DRIVE_SIZE = 70000000;
  const UPDATE_REQUIRES = 30000000;
  const USED_SPACE = folderSizes.find(f => f.name == '').folderSize;
  const FREE_SPACE = DRIVE_SIZE - USED_SPACE;
  const NEEDED = UPDATE_REQUIRES - FREE_SPACE;
  console.log(folderSizes.sort((a, b) => { return a.folderSize - b.folderSize }).filter(f => f.folderSize > NEEDED).map(f => f.folderSize)[0]);
};
run("07-data.txt");