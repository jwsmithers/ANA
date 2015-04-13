// $Id: IByteBufferIterator.h,v 1.1.2.1.2.2 2013-02-08 09:40:07 avalassi Exp $
#ifndef CORALSERVERBASE_IBYTEBUFFERITERATOR_H
#define CORALSERVERBASE_IBYTEBUFFERITERATOR_H 1

// Include files
#include <memory>
#include "CoralServerBase/ByteBuffer.h"

namespace coral
{

  /** @class IByteBufferIterator
   *
   *  Interface to an iterator over ByteBuffer's.
   *
   *  An instance of this interface (returned as a pointer) holds the
   *  replies returned by the IRequestHandler replyToRequest method.
   *
   *  Concrete classes implementing this interface are required to
   *  position the iterator before the first buffer in the loop:
   *  the nextBuffer() method must be called to retrieve the first buffer.
   *
   *  @author Andrea Valassi and Martin Wache
   *  @date   2009-01-23
   *///

  class IByteBufferIterator
  {

  public:

    /// Destructor.
    virtual ~IByteBufferIterator(){}

    /// Get the next buffer.
    virtual bool nextBuffer() = 0;

    /// Is the current buffer the last one?
    /// Throw exception if nextBuffer() was never called (<first buffer).
    /// Throw exception if nextBuffer() returned false (>last buffer).
    virtual bool isLastBuffer() const = 0;

    /// Get a reference to the current buffer.
    /// Throw exception if nextBuffer() was never called (<first buffer).
    /// Throw exception if nextBuffer() returned false (>last buffer).
    virtual const ByteBuffer& currentBuffer() const = 0;

  };

  /// Buffer iterator pointer
  typedef std::auto_ptr<IByteBufferIterator> IByteBufferIteratorPtr;

}
#endif // CORALSERVERBASE_IBYTEBUFFERITERATOR_H
