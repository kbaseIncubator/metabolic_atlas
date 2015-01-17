package Bio::KBase::MetaboliteAtlas::Impl;
use strict;
use Bio::KBase::Exceptions;
# Use Semantic Versioning (2.0.0-rc.1)
# http://semver.org 
our $VERSION = "0.1.0";

=head1 NAME

MetaboliteAtlas

=head1 DESCRIPTION

A web-based atlas to liquid chromatography–mass spectrometry (LCMS) data

=cut

#BEGIN_HEADER
#END_HEADER

sub new
{
    my($class, @args) = @_;
    my $self = {
    };
    bless $self, $class;
    #BEGIN_CONSTRUCTOR
    #END_CONSTRUCTOR

    if ($self->can('_init_instance'))
    {
	$self->_init_instance();
    }
    return $self;
}

=head1 METHODS



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
    my $self = shift;
    my($params) = @_;

    my @_bad_arguments;
    (ref($params) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument \"params\" (value was \"$params\")");
    if (@_bad_arguments) {
	my $msg = "Invalid arguments passed to loadDictionary:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
							       method_name => 'loadDictionary');
    }

    my $ctx = $Bio::KBase::MetaboliteAtlas::Service::CallContext;
    my($output);
    #BEGIN loadDictionary
    #END loadDictionary
    my @_bad_returns;
    (ref($output) eq 'ARRAY') or push(@_bad_returns, "Invalid type for return variable \"output\" (value was \"$output\")");
    if (@_bad_returns) {
	my $msg = "Invalid returns passed to loadDictionary:\n" . join("", map { "\t$_\n" } @_bad_returns);
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
							       method_name => 'loadDictionary');
    }
    return($output);
}




=head2 version 

  $return = $obj->version()

=over 4

=item Parameter and return types

=begin html

<pre>
$return is a string
</pre>

=end html

=begin text

$return is a string

=end text

=item Description

Return the module version. This is a Semantic Versioning number.

=back

=cut

sub version {
    return $VERSION;
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

1;
