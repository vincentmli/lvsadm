package LvsAdm::Gui;
use Dancer ':syntax';
use DBI;
use File::Spec;
use File::Slurp;
use Template;
use Dancer::Plugin::Database;
use Dancer::Plugin::SimpleCRUD;

our $VERSION = '0.1';

simple_crud(
    record_title => 'vs',
    db_table => 'vs',
    prefix => '/',
#    template => 'vs.tt',
    labels => {     # More human-friendly labels for some columns
        vsblock => 'Name',
        virtual => 'Destination',
        real => 'members',
    },
    display_columns  => [ qw( vsblock virtual real scheduler checktype request receive login passwd ) ],
    acceptable_values => {
       scheduler => [
           [ 'wrr', 'weight round robin'],
           [ 'rr', 'round robin'],
       ],
    },

);


true;
