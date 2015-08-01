defmodule MemberfulTest do
  use ExUnit.Case

  alias Hola.Support.ApiCall

  # use the setup_all hook to make sure the API is
  # serving content during tests
  setup_all do
    Hola.Support.Helpers.launch_api
  end

  test "POST with unsupported event returns 200 with error message" do
    payload = ~s({
      "event": "member_canceled"
    }) |> Poison.decode!

    response = ApiCall.post! "/memberful", payload

    assert response.status_code == 200
    assert response.body.message == "Unsupported Event"
    assert !response.body.ok
  end

  test "POST to /memberful with no email returns 200 with ok false" do
    payload = ~s({
      "event": "member_signup",
      "member": {
        "id": 42007,
        "username": "007"
      }
    }) |> Poison.decode!

    response = ApiCall.post! "/memberful", payload

    assert response.status_code == 200
    assert !response.body.ok
  end

  test "POST with correct event and email returns 200 with ok true" do
    payload = ~s({
      "event": "member_signup",
      "member": {
        "id": 42007,
        "username": "007",
        "email": "james.bond@mi6.gov.uk",
        "first_name": "James",
        "last_name": "Bond",
        "full_name": "James Bond",
        "unrestricted_access": false,
        "created_at": 1437578642,
        "stripe_customer_id": "cus_xxxxxxx"
      }
    }) |> Poison.decode!

    response = ApiCall.post! "/memberful", payload

    assert response.status_code == 200
    assert response.body.ok
  end
end
