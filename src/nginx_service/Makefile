up:
	@docker-compose up -d

down:
	@docker-compose down

restart:
	@docker-compose restart

# Auto logs even if it restarts.
logs:
	@trap exit INT; while true; do docker-compose logs -f --tail 10; sleep 1; done

log: logs
