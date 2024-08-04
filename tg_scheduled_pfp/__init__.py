import hashlib
import tempfile
from pathlib import Path

import typer
from telethon import functions
from telethon.sync import TelegramClient


class PFPScheduler:
    api_id_opt = typer.Option(..., envvar='API_ID')
    api_hash_opt = typer.Option(..., envvar='API_HASH')

    def __init__(
        self,
        api_id: int,
        api_hash: str,
    ):
        self.client = TelegramClient(
            session=Path(__file__).parent.joinpath('session'),
            api_id=api_id,
            api_hash=api_hash,
            request_retries=None,
            connection_retries=None,
        )
        self.client.start()

        self._photos = {}
        self._compile_profile_pictures()

    def _compile_profile_pictures(self):
        with tempfile.TemporaryDirectory() as temp_dir:
            for photo in self.client.get_profile_photos(self.client.get_me()):
                photo_path = self.client.download_media(photo, temp_dir)
                with Path(photo_path).open('rb') as file:
                    md5 = hashlib.md5(file.read()).hexdigest()

                self._photos[md5] = photo

    @classmethod
    def list_profile_pictures(
        cls,
        api_id: int = api_id_opt,
        api_hash: str = api_hash_opt,
    ):
        self = cls(
            api_id=api_id,
            api_hash=api_hash,
        )
        self._list_profile_pictures()

    def _list_profile_pictures(self):
        print('Current profile pictures:')
        for i, photo_md5 in enumerate(self._photos, 1):
            print(f'{i}) {photo_md5}')

    @classmethod
    def set_profile_picture(
        cls,
        api_id: int = api_id_opt,
        api_hash: str = api_hash_opt,
        md5: str = typer.Option(...),
    ):
        print(f'Setting profile picture {md5}')
        self = cls(
            api_id=api_id,
            api_hash=api_hash,
        )
        self._set_profile_picture(md5)
        print(f'Profile picture set!')

    def _set_profile_picture(self, md5: str):
        photo = self._photos[md5]
        self.client(functions.photos.UpdateProfilePhotoRequest(id=photo))


def main():
    app = typer.Typer()
    app.command()(PFPScheduler.list_profile_pictures)
    app.command()(PFPScheduler.set_profile_picture)
    app()


if __name__ == '__main__':
    main()
