#!/usr/bin/perl
use strict;
use vars qw($VERSION %IRSSI);

$VERSION = '1.0';
%IRSSI = (
    authors     => 'Marshall Whittaker',
    contact     => 'oxagast@oxasploits.com',
    name        => 'StripColorCodes',
    description => 'Strips IRC special codes from outgoing messages for channels that kick on color use.',
    license     => 'GPL',
);

sub event_send_text {
    my ($line, $serv, $m) = @_;
    if ($line !~ /^\//) {
        # Strip codes from the outgoing message.
        my $cleaned_line = Irssi::strip_codes($line);
        Irssi::signal_stop();
        $serv->command("MSG " . $m->{name} . " " . $cleaned_line);
    }
}

Irssi::signal_add("send text", "event_send_text");

