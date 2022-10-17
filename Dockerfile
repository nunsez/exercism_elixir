FROM elixir:1.14

RUN apt-get update && apt-get install --yes \
    curl \
    git \
    less \
    locales \
    make \
    openssl \
    vim

# Remove apt lists
RUN rm -rf /var/lib/apt/lists/*

# Generate locales
RUN echo en_US.UTF-8 UTF-8 >> /etc/locale.gen
RUN locale-gen
ENV LANG=en_US.UTF-8

# Add docker user with non-root privileges
RUN useradd user --create-home --uid=1000

# Save iex history
ENV ERL_AFLAGS="-kernel shell_history enabled"

# Project setup
ENV PROJECT_ROOT="/app"
ENV HISTFILE="${PROJECT_ROOT}/tmp/.bash_history"
