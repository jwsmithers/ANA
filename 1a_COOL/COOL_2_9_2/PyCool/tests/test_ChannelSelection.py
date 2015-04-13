
import unittest, sys, os

from PyCool import cool
import traceback


connectString = None

class TestChannelSelection( unittest.TestCase ):

    def test_ChannelSelection(self):
        s = cool.ChannelSelection()
        self.assertEquals( cool.UInt32(0), s.firstChannel() )
        self.assertEquals( cool.UInt32(2**32-1), s.lastChannel() )
        self.assertEquals( cool.ChannelSelection.channelBeforeSince, s.order() )
        self.assert_( s.allChannels() )

    def test_ChannelSelection_from_int(self):
        s = cool.ChannelSelection( 5 )
        self.assertEquals( cool.UInt32(5), s.firstChannel() )
        self.assertEquals( cool.UInt32(5), s.lastChannel() )
        self.assertEquals( cool.ChannelSelection.channelBeforeSince, s.order() )
        self.assert_( not s.allChannels() )

    def test_ChannelSelection_from_long(self):
        s = cool.ChannelSelection( 2**31 )
        self.assertEquals( cool.UInt32(2**31), s.firstChannel() )
        self.assertEquals( cool.UInt32(2**31), s.lastChannel() )
        self.assertEquals( cool.ChannelSelection.channelBeforeSince, s.order() )
        self.assert_( not s.allChannels() )

    def test_ChannelSelection_order(self):
        s = cool.ChannelSelection( order = cool.ChannelSelection.sinceBeforeChannel )
        self.assertEquals( cool.UInt32(0), s.firstChannel() )
        self.assertEquals( cool.UInt32(2**32-1), s.lastChannel() )
        self.assertEquals( cool.ChannelSelection.sinceBeforeChannel, s.order() )
        self.assert_( s.allChannels() )

    def test_ChannelSelection_range(self):
        s = cool.ChannelSelection( 5, 10 )
        self.assertEquals( cool.UInt32(5), s.firstChannel() )
        self.assertEquals( cool.UInt32(10), s.lastChannel() )
        self.assertEquals( cool.ChannelSelection.channelBeforeSince, s.order() )

    def test_ChannelSelection_range_order(self):
        s = cool.ChannelSelection( 5, 10,
                                   cool.ChannelSelection.sinceBeforeChannel )
        self.assertEquals( cool.UInt32(5), s.firstChannel() )
        self.assertEquals( cool.UInt32(10), s.lastChannel() )
        self.assertEquals( cool.ChannelSelection.sinceBeforeChannel, s.order() )

    def test_ChannelSelection_ArgumentError(self):
        self.assertRaises( TypeError, cool.ChannelSelection, 1, 2, 3, 4 )

    def test_allChannels(self):
        s = cool.ChannelSelection()
        self.assert_( s.allChannels() )

    def test_all(self):
        s = cool.ChannelSelection.all()
        self.assertEquals( cool.UInt32(0), s.firstChannel() )
        self.assertEquals( cool.UInt32(2**32-1), s.lastChannel() )
        self.assertEquals( cool.ChannelSelection.channelBeforeSince, s.order() )
        self.assert_( s.allChannels() )

    def test_ChannelSelection_above_maxint(self):
        s = cool.ChannelSelection( 2**31, 2**31+1 )
        self.assertEquals( cool.UInt32(2**31), s.firstChannel() )
        self.assertEquals( cool.UInt32(2**31+1), s.lastChannel() )

#######################################################################


if __name__ == '__main__':
    unittest.main( testRunner =
                   unittest.TextTestRunner(stream=sys.stdout,verbosity=2) )

