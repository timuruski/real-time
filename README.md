# Real-Time

## Poll service

To fetch a list of available polls.

    # Request: GET /polls

    # Response 200
    {
      "polls": [
        {
          "name": "Best Starship Captain",
          "href": "/polls/123"
        },
        { ... }
      ]
    }

To fetch a single poll.

    # Request: GET /polls/<id>/

    # Response: 200
    {
      "name": "Best Starship Captain",
      "href": "/polls/123",
      "options": [
        {
          "name": "Jean Luc Picard",
          "votes": 34,
          "href": "/polls/123/jean-luc-picard"
        },
        { ... }
      ]
    }

Create a new poll.

    # Request: POST /polls
    {
      "name": "Best Starship Captain",
      "options": [
        "Jean Luc Picard",
        "James Kirk",
        "Benjamin Sisko",
        "Kathryn Janeway",
        "Jonathan Archer"
      ]
    }

    # Response: 201

    { "href": "/polls/123" }

Voting for an option.

    # Request: POST /polls/<id>/<option>

    # Response: 200

    { "href": "/polls/123" }
