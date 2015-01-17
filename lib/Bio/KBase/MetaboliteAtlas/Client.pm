package Bio::KBase::MetaboliteAtlas::Client;

use JSON::RPC::Client;
use strict;
use Data::Dumper;
use URI;
use Bio::KBase::Exceptions;
use Bio::KBase::AuthToken;

# Client version should match Impl version
# This is a Semantic Version number,
# http://semver.org
our $VERSION = "0.1.0";

=head1 NAME

Bio::KBase::MetaboliteAtlas::Client

=head1 DESCRIPTION


A web-based atlas to liquid chromatography–mass spectrometry (LCMS) data


=cut

sub new
{
    my($class, $url, @args) = @_;
    

    my $self = {
	client => Bio::KBase::MetaboliteAtlas::Client::RpcClient->new,
	url => $url,
    };

    #
    # This module requires authentication.
    #
    # We create an auth token, passing through the arguments that we were (hopefully) given.

    {
	my $token = Bio::KBase::AuthToken->new(@args);
	
	if (!$token->error_message)
	{
	    $self->{token} = $token->token;
	    $self->{client}->{token} = $token->token;
	}
        else
        {
	    #
	    # All methods in this module require authentication. In this case, if we
	    # don't have a token, we can't continue.
	    #
	    die "Authentication failed: " . $token->error_message;
	}
    }

    my $ua = $self->{client}->ua;	 
    my $timeout = $ENV{CDMI_TIMEOUT} || (30 * 60);	 
    $ua->timeout($timeout);
    bless $self, $class;
    #    $self->_validate_version();
    return $self;
}




=head2 loadDictionary

  $output = $obj->loadDictionary($params)

=over 4

=item Parameter and return types

=begin html

<pre>
$params is a LoadDictionary
$output is an object_metadata
LoadDictionary is a reference to a hash where the following keys are defined:
	workspace has a value which is a string
	username has a value which is a string
	dict_id has a value which is a string
object_metadata is a reference to a list containing 11 items:
	0: (id) an object_id
	1: (type) an object_type
	2: (moddate) a timestamp
	3: (instance) an int
	4: (command) a string
	5: (lastmodifier) a username
	6: (owner) a username
	7: (workspace) a workspace_id
	8: (ref) a workspace_ref
	9: (chsum) a string
	10: (metadata) a string
object_id is a string
object_type is a string
timestamp is a string
username is a string
workspace_id is a string
workspace_ref is a string

</pre>

=end html

=begin text

$params is a LoadDictionary
$output is an object_metadata
LoadDictionary is a reference to a hash where the following keys are defined:
	workspace has a value which is a string
	username has a value which is a string
	dict_id has a value which is a string
object_metadata is a reference to a list containing 11 items:
	0: (id) an object_id
	1: (type) an object_type
	2: (moddate) a timestamp
	3: (instance) an int
	4: (command) a string
	5: (lastmodifier) a username
	6: (owner) a username
	7: (workspace) a workspace_id
	8: (ref) a workspace_ref
	9: (chsum) a string
	10: (metadata) a string
object_id is a string
object_type is a string
timestamp is a string
username is a string
workspace_id is a string
workspace_ref is a string


=end text

=item Description

Load a metabolite dictionary given a dictionary id and credentials.  Results are stored in a Dictionary object.  Returns the
metadata for the metabolite dictionary object.

=back

=cut

sub loadDictionary
{
    my($self, @args) = @_;

# Authentication: required

    if ((my $n = @args) != 1)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function loadDictionary (received $n, expecting 1)");
    }
    {
	my($params) = @args;

	my @_bad_arguments;
        (ref($params) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 1 \"params\" (value was \"$params\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to loadDictionary:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'loadDictionary');
	}
    }

    my $result = $self->{client}->call($self->{url}, {
	method => "MetaboliteAtlas.loadDictionary",
	params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{code},
					       method_name => 'loadDictionary',
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method loadDictionary",
					    status_line => $self->{client}->status_line,
					    method_name => 'loadDictionary',
				       );
    }
}



sub version {
    my ($self) = @_;
    my $result = $self->{client}->call($self->{url}, {
        method => "MetaboliteAtlas.version",
        params => [],
    });
    if ($result) {
        if ($result->is_error) {
            Bio::KBase::Exceptions::JSONRPC->throw(
                error => $result->error_message,
                code => $result->content->{code},
                method_name => 'loadDictionary',
            );
        } else {
            return wantarray ? @{$result->result} : $result->result->[0];
        }
    } else {
        Bio::KBase::Exceptions::HTTP->throw(
            error => "Error invoking method loadDictionary",
            status_line => $self->{client}->status_line,
            method_name => 'loadDictionary',
        );
    }
}

sub _validate_version {
    my ($self) = @_;
    my $svr_version = $self->version();
    my $client_version = $VERSION;
    my ($cMajor, $cMinor) = split(/\./, $client_version);
    my ($sMajor, $sMinor) = split(/\./, $svr_version);
    if ($sMajor != $cMajor) {
        Bio::KBase::Exceptions::ClientServerIncompatible->throw(
            error => "Major version numbers differ.",
            server_version => $svr_version,
            client_version => $client_version
        );
    }
    if ($sMinor < $cMinor) {
        Bio::KBase::Exceptions::ClientServerIncompatible->throw(
            error => "Client minor version greater than Server minor version.",
            server_version => $svr_version,
            client_version => $client_version
        );
    }
    if ($sMinor > $cMinor) {
        warn "New client version available for Bio::KBase::MetaboliteAtlas::Client\n";
    }
    if ($sMajor == 0) {
        warn "Bio::KBase::MetaboliteAtlas::Client version is $svr_version. API subject to change.\n";
    }
}

=head1 TYPES



=head2 workspace_id

=over 4



=item Description

A string identifier for a workspace. Any string consisting of alphanumeric characters and "-" is acceptable.


=item Definition

=begin html

<pre>
a string
</pre>

=end html

=begin text

a string

=end text

=back



=head2 object_type

=over 4



=item Description

A string indicating the type of an object stored in a workspace.


=item Definition

=begin html

<pre>
a string
</pre>

=end html

=begin text

a string

=end text

=back



=head2 object_id

=over 4



=item Description

ID of an object stored in the workspace.


=item Definition

=begin html

<pre>
a string
</pre>

=end html

=begin text

a string

=end text

=back



=head2 username

=over 4



=item Description

Login name of KBase user account to which permissions for workspaces are mapped


=item Definition

=begin html

<pre>
a string
</pre>

=end html

=begin text

a string

=end text

=back



=head2 timestamp

=over 4



=item Description

Exact time for workspace operations. e.g. 2012-12-17T23:24:06


=item Definition

=begin html

<pre>
a string
</pre>

=end html

=begin text

a string

=end text

=back



=head2 workspace_ref

=over 4



=item Description

A permanent reference to an object in a workspace.


=item Definition

=begin html

<pre>
a string
</pre>

=end html

=begin text

a string

=end text

=back



=head2 object_metadata

=over 4



=item Definition

=begin html

<pre>
a reference to a list containing 11 items:
0: (id) an object_id
1: (type) an object_type
2: (moddate) a timestamp
3: (instance) an int
4: (command) a string
5: (lastmodifier) a username
6: (owner) a username
7: (workspace) a workspace_id
8: (ref) a workspace_ref
9: (chsum) a string
10: (metadata) a string

</pre>

=end html

=begin text

a reference to a list containing 11 items:
0: (id) an object_id
1: (type) an object_type
2: (moddate) a timestamp
3: (instance) an int
4: (command) a string
5: (lastmodifier) a username
6: (owner) a username
7: (workspace) a workspace_id
8: (ref) a workspace_ref
9: (chsum) a string
10: (metadata) a string


=end text

=back



=head2 Compound

=over 4



=item Description

Metabolite dictionary object
*  
*  name - common name of the compound
*  formula - chemical formula
*  adducts - adduct ions
*  mz - mass-to-charge ratio
*  mz_threshold - threshold in ppm
*  rt_min - min retention time
*  rt_max - max retention time
*  rt_peak - peak retention time
*


=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
name has a value which is a string
formula has a value which is a string
adducts has a value which is a string
mz has a value which is a string
mz_threshold has a value which is a string
rt_min has a value which is a string
rt_max has a value which is a string
rt_peak has a value which is a string
neutral_mass has a value which is a string
pubchem_id has a value which is a string
dict_id has a value which is a string
creator has a value which is a string
creation_date has a value which is a string

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
name has a value which is a string
formula has a value which is a string
adducts has a value which is a string
mz has a value which is a string
mz_threshold has a value which is a string
rt_min has a value which is a string
rt_max has a value which is a string
rt_peak has a value which is a string
neutral_mass has a value which is a string
pubchem_id has a value which is a string
dict_id has a value which is a string
creator has a value which is a string
creation_date has a value which is a string


=end text

=back



=head2 CompoundList

=over 4



=item Definition

=begin html

<pre>
a reference to a list where each element is a Compound
</pre>

=end html

=begin text

a reference to a list where each element is a Compound

=end text

=back



=head2 Dictionary

=over 4



=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
name has a value which is a string
compounds has a value which is a CompoundList
creator has a value which is a string
creation_date has a value which is a string
sample has a value which is a string
method has a value which is a string

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
name has a value which is a string
compounds has a value which is a CompoundList
creator has a value which is a string
creation_date has a value which is a string
sample has a value which is a string
method has a value which is a string


=end text

=back



=head2 LoadDictionary

=over 4



=item Description

Input parameters for the "load dictionary" function.


=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
workspace has a value which is a string
username has a value which is a string
dict_id has a value which is a string

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
workspace has a value which is a string
username has a value which is a string
dict_id has a value which is a string


=end text

=back



=cut

package Bio::KBase::MetaboliteAtlas::Client::RpcClient;
use base 'JSON::RPC::Client';

#
# Override JSON::RPC::Client::call because it doesn't handle error returns properly.
#

sub call {
    my ($self, $uri, $obj) = @_;
    my $result;

    if ($uri =~ /\?/) {
       $result = $self->_get($uri);
    }
    else {
        Carp::croak "not hashref." unless (ref $obj eq 'HASH');
        $result = $self->_post($uri, $obj);
    }

    my $service = $obj->{method} =~ /^system\./ if ( $obj );

    $self->status_line($result->status_line);

    if ($result->is_success) {

        return unless($result->content); # notification?

        if ($service) {
            return JSON::RPC::ServiceObject->new($result, $self->json);
        }

        return JSON::RPC::ReturnObject->new($result, $self->json);
    }
    elsif ($result->content_type eq 'application/json')
    {
        return JSON::RPC::ReturnObject->new($result, $self->json);
    }
    else {
        return;
    }
}


sub _post {
    my ($self, $uri, $obj) = @_;
    my $json = $self->json;

    $obj->{version} ||= $self->{version} || '1.1';

    if ($obj->{version} eq '1.0') {
        delete $obj->{version};
        if (exists $obj->{id}) {
            $self->id($obj->{id}) if ($obj->{id}); # if undef, it is notification.
        }
        else {
            $obj->{id} = $self->id || ($self->id('JSON::RPC::Client'));
        }
    }
    else {
        # $obj->{id} = $self->id if (defined $self->id);
	# Assign a random number to the id if one hasn't been set
	$obj->{id} = (defined $self->id) ? $self->id : substr(rand(),2);
    }

    my $content = $json->encode($obj);

    $self->ua->post(
        $uri,
        Content_Type   => $self->{content_type},
        Content        => $content,
        Accept         => 'application/json',
	($self->{token} ? (Authorization => $self->{token}) : ()),
    );
}



1;
