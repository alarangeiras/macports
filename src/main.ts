import { exec } from "child_process";
import { promisify } from "util";

async function main() {
    const result = await promisify(exec)("sudo lsof -iTCP -sTCP:LISTEN -n -P");
    console.log(result.stdout);
}

main();