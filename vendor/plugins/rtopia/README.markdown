Rtopia
======

A very simple, but useful route generation helper for use anytime, anywhere. 
See documentation at [http://labs.sinefunc.com/rtopia/doc](http://labs.sinefunc.com/rtopia/doc).

Assumptions
-----------

It checks for a `to_param`, and if Ruby1.9 or greater is used, checks for an `id`. Last fallback uses `to_s`.

Examples
--------

    include Rtopia

    R(:items) # => /items

    # this appears to be redundant, take it with a grain of salt
    # although it would probably be used for consistency's sake
    R('/') # => '/'
    
    @person = Person.new # has a to_param of john-doe
    R(@person) # => '/john-doe'
    R(@person, :posts) # => '/john-doe/posts'
    R(@person, :posts, :replied) # => '/john-doe/posts/replied'

    @entry = Entry.create # has an id of 1001 for example
    R(@entry) # => '/1001'
    R(:entry, @entry) # => '/entry/1001'
