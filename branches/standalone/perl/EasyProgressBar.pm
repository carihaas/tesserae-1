# how to draw a simple progress bar

package ProgressBar;

require Exporter;

our @ISA = qw(Exporter);

our @EXPORT = qw(ProgressBar);
	
sub new {
	my $self = {};
	
	shift;
	
	my $terminus = shift || die "ProgressBar->new() called with no final value";
	
	$self->{END} = $terminus;
	
	my $quiet = shift || 0;
	
	$self->{COUNT} = 0;
	$self->{PROGRESS} = 0;
	
	print STDERR "0% |" . (" " x 40) . "| 100%" unless $quiet;
	
	bless($self);
	return $self;
}

sub advance {

	my $self = shift;
	
	my $incr = shift;

	my $quiet = shift || 0;
	
	if (defined $incr)	{ $self->{COUNT} += $incr }
	else			   	{ $self->{COUNT}++ }
	
	$self->draw() unless $quiet;
}

sub set {

	my $self = shift;
	
	my $new = shift || 0;
	
	my $quiet = shift || 0;
	
	$self->{COUNT} = $new;
	
	$self->draw() unless $quiet;
}

sub draw {

	my $self = shift;
	
	if ($self->{COUNT}/$self->{END} > $self->{PROGRESS} + .025) {
		
		$self->{PROGRESS} = $self->{COUNT} / $self->{END};
		
		my $bars = int($self->{PROGRESS} * 41);
		if ($bars == 41) { $bars-- }
		
		print STDERR "\r" . "0% |" . ("#" x $bars) . (" " x (40 - $bars)) . "| 100%";
	}
	
	if ($self->{COUNT} >= $self->{END}) {
		
		$self->finish();
	}	
}

sub finish {

	print STDERR "\n";
}

sub progress {
	
	my $self = shift;
	
	return $self->{COUNT};
}

sub terminus {

	my $self = shift;
	
	return $self->{END};
}

1;