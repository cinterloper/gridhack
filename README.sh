#!/bin/bash
#gridhack is a minesweeper clone implemented in lua-bash
docker run -t -i -v $(pwd):$(pwd) cinterloper/bash-json \
	bash -c "source /opt/json.bashrc && cd $(pwd) && source game.sh && main"
