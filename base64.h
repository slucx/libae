#pragma once

#ifdef __cplusplus
extern "C" {
#endif

/*
 * @brief Calculate the length of encoded buffer
 * @param len_plain_src the length of buffer to be encoded
 * @return the length of encoded buffer
 */
int b64_encode_len(int len_plain_src);

/*
 * @brief Base64 encode algorithm
 * @param coded_dst the buffer contains encoded string
 * @param plain_src the buffer to be encoded
 * @param len_plain_src the length of buffer to be encoded
 * @return the length of encoded buffer
 */
int b64_encode(char* coded_dst, const char* plain_src, int len_plain_src);

/*
 * @brief Calculate the length of unencoded string
 * @param coded_src the buffer contains encoded string
 * @return the length of unencoded string
 */
int b64_decode_len(const char* coded_src);

/*
 * @brief Base64 decode algorithm
 * @param plain_dst the buffer contains unencoded string
 * @param coded_src the buffer contains encoded string
 * @return the length of unencoded string
 */
int b64_decode(char* plain_dst, const char* coded_src);

#ifdef __cplusplus
}
#endif
