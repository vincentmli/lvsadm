package LvsAdm::Gui;
use Dancer ':syntax';
use DBI;
use File::Spec;
use File::Slurp;
use Template;
use Dancer::Plugin::Database;
use Dancer::Plugin::SimpleCRUD;
use Config::Ldirectord;

our $VERSION = '0.1';

simple_crud(
    record_title => 'vs',
    db_table => 'vs',
    prefix => '/vs',
#    template => 'vs.tt',
    deleteable => 1,
    labels => {     # More human-friendly labels for some columns
        vsblock => 'Name',
        virtual => 'Destination',
        real => 'members',
    },
    display_columns  => [ qw( vsblock virtual protocol real scheduler request receive login passwd ) ],
    acceptable_values => {
       scheduler => [
           [ 'wrr', 'weight round robin'],
           [ 'rr', 'round robin'],
       ],
    },
    auth => {
        view => {
            require_login => 1,
        },
        edit => {
            require_role => 'editor',
        },
    },

);

simple_crud(
    record_title => 'global',
    db_table => 'global',
    prefix => '/global',
#    template => 'vs.tt',
    labels => {     # More human-friendly labels for some columns
        autoreload => 'auto reload',
        logfile => 'log file',
    },
    display_columns  => [ qw( autoreload logfile ) ],
    acceptable_values => {
       autoreload => [
           [ 'yes', 'yes'],
           [ 'no', 'no'],
       ],
    },
    auth => {
        view => {
            require_login => 1,
        },
        edit => {
            require_role => 'editor',
        },
    },

);

get '/' => sub {
    redirect '/vs';
};



true;
