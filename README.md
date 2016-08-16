Introduction
============

Sometimes you find yourself in a situation where you need to enforce part of a
catalog based on some condition. Perhaps you have custom facts that don't get
set until the second Puppet run, or maybe you need to gate enforcement on
something external that's not managed. Perhaps you just want to sanity check
that a machine has been provisioned properly before being handed to Puppet, and
you'd like a sane error message if not.

The `assert` type allows you to do dependency based partial catalogs. By adding
an `assert` resource to your catalog, you can selectively skip any resources
that express a dependency on it. This provides a straightforward way to manage
partial enforcement without complex logic. It also retains a full catalog so you
have a record of what was skipped and why.

The assert type includes simple fact assertions, several file path based
assertions, and a command success assertion. See `puppet describe assert` for a
full list of supported assertions.

Remember that Puppet handles undefined variables as `undef` which evaluates to
`false`. This means that you can simply assert on a custom fact and it will fail
if that fact does not exist.

You can invert an assert by setting its ensure parameter to absent.


Usage
=======

    assert { 'This should be applied':
      condition => true
    } -> 
    class { 'two': }
    
    assert { 'This should NOT be applied':
      condition => false
    } -> 
    class { 'three': }
    
    assert { 'This should be applied':
      ensure => absent,
      condition => false
    } -> 
    class { 'four': }

    assert { 'This should be applied if the directory exists':
      directory => '/etc/custom'
    } -> 
    class { 'five': }

    assert { 'This should be applied if the command succeeds':
      command => 'ping -c1 database.example.com'
    } -> 
    class { 'six': }



Contact
=======

* Author: Ben Ford
* Email: ben.ford@puppet.com
* Twitter: @binford2k
* IRC (Freenode): binford2k


Credit
=======

The initial development of this code was sponsored by Coverity.


License
=======

Copyright (c) 2016 Ben Ford, ben.ford@puppet.com  
Copyright (c) 2012 Puppet Labs, info@puppetlabs.com  
Copyright (c) 2012 Coverity.com, mllaguno@coverity.com

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.