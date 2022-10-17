FROM elixir:1.14

RUN useradd user --create-home --uid=1000

ENV LANG=en_US.UTF-8
ENV PROJECT_ROOT="/app"
ENV HISTFILE="${PROJECT_ROOT}/tmp/.bash_history"
