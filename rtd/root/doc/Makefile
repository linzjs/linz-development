# Makefile for Sphinx documentation
#

# You can set these variables from the command line.
SRCDIR        = ./src
SPHINXOPTS    = -T -E -b readthedocs -c ./
SPHINXBUILD   = sphinx-build
PAPER         =
BUILDDIR      = _build

clean:
	rm -rf $(BUILDDIR)/*

html:
	$(SPHINXBUILD) $(SPHINXOPTS) $(SRCDIR) $(BUILDDIR)/html
	@echo
	@echo "Build finished. The HTML pages are in $(BUILDDIR)/html."
