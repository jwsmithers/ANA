#ifndef ACE_ERRORS_H
#define ACE_ERRORS_H

#include <string>

namespace ace_errors {

class EmptyFolder {
public:
    EmptyFolder() {}
    ~EmptyFolder() {}
    std::string what() const { return( "Empty folder" ); }
}; // EmptyFolder

} // namespace ace_errors

#endif

