#ifndef CORALSERVERBASE_CTLSTATUS_H
#define CORALSERVERBASE_CTLSTATUS_H 1

namespace coral
{
  /** @enum CTLStatus
   *
   *  Status code of a CORAL transport layer reply.
   *
   *  @author Andrea Valassi
   *  @date   2009-01-22
   *///

  /// Enum definition.
  enum CTLStatus { CTLOK = 0,
                   CTLWrongMagicWord = 1,
                   CTLWrongVersion = 2,
                   CTLWrongChecksum = 3 };
}

#endif // CORALSERVERBASE_CTLSTATUS_H
