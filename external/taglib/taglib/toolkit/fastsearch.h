#pragma once

#include <cstddef>

namespace TagLib
{
int findCharFast(const char* data, size_t dataSize, char c, unsigned int& offset);
int findVectorFast(const char* data, size_t dataSize, const char* pattern, size_t patternSize, unsigned int& offset);
}
