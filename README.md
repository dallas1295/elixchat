# Elixchat

Elixchat is a simple TCP Socket-based chat app in the terminal. Learning about recursion and casing within elixir

# TODO: Fix problems

**Real-time**: real time isn't working yet (one client updates but the other does not until after message sent)
**Formating**: the formating is atrocious and needs to be fixed
**Multi-Client**: multiple client connections are not updating at the same time
**Chat names**: need to set up some simple way to set user names into the chat window

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `elixchat` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:elixchat, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/elixchat>.
