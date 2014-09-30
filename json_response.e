note
	description: "Summary description for {WSF_PAGE_RESPONSE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_RESPONSE

inherit
	WSF_RESPONSE_MESSAGE

create
	make

feature {NONE} -- Initialization

	make
		do
			status_code := 200
		end

feature -- Status

	status_code: INTEGER

feature -- Header

	header: WSF_HEADER

feature -- Json access

	body: detachable STRING

feature -- Element change

	set_status_code (c: like status_code)
		do
			status_code := c
		end
	set_body (b: like body)
		do
			body := b
		end

feature {WSF_RESPONSE} -- Output

	send_to (res: WSF_RESPONSE)
		local

			s: STRING_8
		do
			create s.make (64)
			create header.make
			s.append ("")
			append_html_body_code (s)
			res.set_status_code (status_code)
			header.add_content_type ("application/json")
			header.add_header_key_value ("Access-Control-Allow-Origin", "*")
			res.put_header_text (header.string)
			res.put_string (s)
		end

feature -- HTML facilities


feature {NONE} -- HTML Generation

	append_html_body_code (s: STRING_8)
		local
			b: like body
		do
			b := body
			if b /= Void then
				s.append (b)
			end
		end
end
