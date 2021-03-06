"""Peewee migrations -- 001_init_data_tables.py.

Some examples (model - class or model name)::

    > Model = migrator.orm['model_name']            # Return model in current state by name

    > migrator.sql(sql)                             # Run custom SQL
    > migrator.python(func, *args, **kwargs)        # Run python code
    > migrator.create_model(Model)                  # Create a model (could be used as decorator)
    > migrator.remove_model(model, cascade=True)    # Remove a model
    > migrator.add_fields(model, **fields)          # Add fields to a model
    > migrator.change_fields(model, **fields)       # Change fields
    > migrator.remove_fields(model, *field_names, cascade=True)
    > migrator.rename_field(model, old_field_name, new_field_name)
    > migrator.rename_table(model, new_table_name)
    > migrator.add_index(model, *col_names, unique=False)
    > migrator.drop_index(model, *col_names)
    > migrator.add_not_null(model, *field_names)
    > migrator.drop_not_null(model, *field_names)
    > migrator.add_default(model, field_name, default)

"""
import peewee as pw


def migrate(migrator, database, fake=False, **kwargs):
    """Write your migrations here."""

    migrator.python(insert_roles, database, migrator)


def insert_roles(db, migrator):
    serv_table = migrator.orm['servers']
    data_to_insert = [
        {'name': 'local', 'ip':  '127.0.0.1'},
        {'name': 'main-central', 'ip':  '10.10.10.10'},
        {'name': 'backup-central', 'ip':  '192.168.1.10'}
    ]
    with db.atomic():
        serv_table.insert_many(data_to_insert).execute()

def rollback(migrator, database, fake=False, **kwargs):
    """Write your rollback migrations here."""

    print('Insert failed')


