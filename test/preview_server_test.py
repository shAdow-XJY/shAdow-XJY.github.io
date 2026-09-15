import functools
import http.client
import tempfile
import threading
import unittest
from pathlib import Path
from http.server import ThreadingHTTPServer
from tool.preview_web import PreviewHandler


class RangePreviewTest(unittest.TestCase):
    def test_full_partial_suffix_and_invalid_ranges(self):
        with tempfile.TemporaryDirectory() as folder:
            Path(folder, 'clip.mp4').write_bytes(b'0123456789')
            server = ThreadingHTTPServer(('127.0.0.1', 0),
                functools.partial(PreviewHandler, directory=folder))
            thread = threading.Thread(target=server.serve_forever, daemon=True)
            thread.start()
            try:
                for requested, expected_status, expected_data in [
                    (None, 200, b'0123456789'), ('bytes=2-5', 206, b'2345'),
                    ('bytes=8-', 206, b'89'), ('bytes=-3', 206, b'789'),
                    ('bytes=10-', 416, b''), ('bytes=5-2', 416, b''),
                    ('bytes=-0', 416, b'')]:
                    connection = http.client.HTTPConnection(*server.server_address)
                    headers = {'Range': requested} if requested else {}
                    connection.request('GET', '/clip.mp4', headers=headers)
                    response = connection.getresponse()
                    self.assertEqual(response.status, expected_status)
                    self.assertEqual(response.read(), expected_data)
                    connection.close()
            finally:
                server.shutdown()
                server.server_close()
                thread.join()


if __name__ == '__main__':
    unittest.main()
