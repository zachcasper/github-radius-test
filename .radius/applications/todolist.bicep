extension radius
extension containers
extension postgresqldatabases

param environment string 

resource todolist 'Radius.Core/applications@2025-08-01-preview' = {
  name: 'todolist'
  properties: {
    environment: environment
  }
}

resource frontend 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'frontend'
  properties: {
    application: todolist.id
    environment: environment
    containers: {
      frontend: {
        image: 'ghcr.io/radius-project/samples/demo:latest'
        ports: {
          web: {
            containerPort: 3000
          }
        }
      }
    }
    connections: {
      postgresql:{
        source: db.id
      }
    }
  }
}

resource db 'Radius.Data/postgreSqlDatabases@2025-08-01-preview' = {
  name: 'db'
  properties: {
    environment: environment
    application: todolist.id
    size: 'S'
  }
}
