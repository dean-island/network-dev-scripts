# Network Development Scripts

Custom development scripts and configuration for the network project. These scripts provide convenient shortcuts for building, testing, linting, and managing the core network codebase.

## Overview

This repository contains:
- **direnv configuration** (`.envrc`) - Environment setup for the network project
- **.direnv directory** - Contains Neovim config and development scripts
  - **Neovim configuration** (`.direnv/.nvim.lua`) - Project-specific Neovim settings
  - **Development scripts** (`.direnv/bin/`) - Build, test, and utility scripts

## Setup

This repository is designed to be used via symbolic links from the network bare repository.

### Quick Setup

Run the setup script to create the necessary symbolic links:

```bash
./setup.sh
```

This will create:
- `~/work/network/.direnv` → `~/work/network-scripts/.direnv`
- `~/work/network/.envrc` → `~/work/network-scripts/.envrc`

### Manual Setup

If you prefer to set up manually:

```bash
# Create directory symlink
ln -sf ~/work/network-scripts/.direnv ~/work/network/.direnv

# Create file symlink
ln -sf ~/work/network-scripts/.envrc ~/work/network/.envrc

# Reload direnv
cd ~/work/network
direnv allow
```

## Requirements

- **direnv** - For environment variable management
- **Go 1.22+** - Required for building and testing
- **Docker** - Required for E2E tests and container management
- **Task** - Task runner for build commands
- **golangci-lint** - For code linting
- **ripgrep (rg)** - For fast text search

## Available Scripts

### Build Scripts

#### `build`
Builds the core-network project with CGO flags and displays a spinner during compilation.

```bash
build
```

### Test Scripts

#### `ut` (Unit Test)
Runs a specific unit test by name. Uses ripgrep to find the test location and runs it with race detection.

```bash
ut TestName [additional-go-test-flags]
```

#### `ut-all`
Runs all unit tests in the core-network project.

```bash
ut-all
```

#### `ut-specific`
Runs unit tests for a specific package path.

```bash
ut-specific ./pkg/some/package
```

#### `e2e` (End-to-End)
Builds all components and runs end-to-end integration tests with Docker Compose scenarios.

```bash
e2e [test-filter]
```

Environment variables:
- `CORE_NETWORK_E2E_PARALLEL` - Number of parallel test runs (default: 3)

#### `e2e-no-build`
Runs E2E tests without rebuilding components (faster for iterative testing).

```bash
e2e-no-build [test-filter]
```

#### `e2eperf`
Runs E2E performance tests.

```bash
e2eperf
```

### Linting Scripts

#### `lint`
Runs linters on modified Go files. Automatically detects changes and runs appropriate linters:
- golangci-lint
- custom linters
- mock generation
- checklocks linter (for core-network)

```bash
lint
```

### Utility Scripts

#### `clean_containers`
Removes all Docker containers (useful for cleaning up test environments).

```bash
clean_containers
```

#### `clean_network`
Prunes unused Docker networks.

```bash
clean_network
```

#### `conn-check`
Checks network connectivity and connection status (likely for testing network components).

```bash
conn-check
```

#### `route-check`
Checks routing configuration and status.

```bash
route-check
```

#### `sync-main`
Synchronizes the main branch (likely updates main worktree from remote).

```bash
sync-main
```

#### `pull-ziggy`
Pulls ziggy-related updates (custom deployment/testing tool).

```bash
pull-ziggy
```

#### `push-ziggy`
Pushes ziggy-related updates.

```bash
push-ziggy
```

## Configuration Files

### `.envrc`
Sets up the development environment when entering the network directory. Includes:
- Python environment (pyenv)
- Go workspace configuration
- PATH additions for local scripts and tools
- Custom environment variables

### `.nvim.lua`
Neovim project-specific configuration for LSP and editor settings.

## Development Workflow

1. Navigate to the network directory:
   ```bash
   cd ~/work/network
   ```

2. Make code changes in your worktree

3. Run tests:
   ```bash
   ut TestName        # Run specific test
   ut-all             # Run all unit tests
   e2e                # Run E2E tests
   ```

4. Run linters before committing:
   ```bash
   lint
   ```

5. Build if needed:
   ```bash
   build
   ```

## Maintenance

To update these scripts:

1. Edit scripts in this repository (`~/work/network-scripts/`)
2. Commit and push changes
3. Changes are immediately available via symlinks at `~/work/network/.direnv/bin/`

## Troubleshooting

### Scripts not found
```bash
# Verify symlinks exist
ls -la ~/work/network/.direnv
ls -la ~/work/network/.envrc

# Re-run setup if needed
./setup.sh
```

### direnv not loading
```bash
cd ~/work/network
direnv allow
```

### Scripts not executable
```bash
chmod +x ~/work/network-scripts/bin/*
```

## Repository Structure

```
network-dev-scripts/
├── .direnv/              # Directory symlinked to ~/work/network/.direnv
│   ├── .nvim.lua         # Neovim configuration
│   └── bin/              # Development scripts
│       ├── build         # Build core-network
│       ├── clean_containers  # Clean Docker containers
│       ├── clean_network     # Clean Docker networks
│       ├── conn-check        # Check connections
│       ├── e2e               # Run E2E tests
│       ├── e2e-no-build      # Run E2E without build
│       ├── e2eperf           # Run E2E performance tests
│       ├── lint              # Run linters
│       ├── pull-ziggy        # Pull ziggy updates
│       ├── push-ziggy        # Push ziggy updates
│       ├── route-check       # Check routes
│       ├── sync-main         # Sync main branch
│       ├── ut                # Run specific unit test
│       ├── ut-all            # Run all unit tests
│       └── ut-specific       # Run tests for specific package
├── .envrc                # direnv configuration (symlinked)
├── .gitignore            # Git ignore patterns
├── README.md             # This file
└── setup.sh              # Symlink setup script
```

## License

Private repository for internal development use.
