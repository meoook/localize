// class AbyApi {
//   final _httpClient = ServiceHttpClient();
//
//   Future<ModelProjects> projectList() async {
//     return await _httpClient.get('prj').then((value) => ModelProjects.fromJson(value));
//   }
//
//   Future<ModelProject> projectAdd(String name, String iChars, int langOrig, List translate) async {
//     var _payload = {'name': name, 'icon_chars': iChars, 'lang_orig': langOrig, 'translate_to': translate};
//     return await _httpClient.post('prj', data: _payload).then((value) => ModelProject.fromJson(value));
//   }
//
//   Future<ModelProject> projectUpdate(ModelProject project) async {
//     var _payload = project.apiMap;
//     return await _httpClient.post('prj/${project.id}', data: _payload).then((value) => ModelProject.fromJson(value));
//   }
//
//   Future<bool> projectDelete(String projectID) async {
//     return await _httpClient.request(Method.DELETE, 'prj/$projectID');
//   }
//
//   Future<List> folderList(String projectID) async {
//     return await _httpClient.get('prj/folder', params: {'save_id': projectID});
//   }
// ===============================================================

// // FOLDERS
// const fldrList = async (save_id) => {
// try {
// const res = await axios.get(`${URL}/prj/folder/`, {
// ...config,
// params: { save_id },
// })
// dispatch({ type: PRJ_FOLDER_REFRESH, payload: res.data })
// } catch (err) {
// addMsg(connectErrMsg(err, 'Ошибка получения списка папок'))
// }
// }
// const fldrAdd = async (folder) => {
// try {
// const res = await axios.post(`${URL}/prj/folder/`, folder, config)
// dispatch({ type: PRJ_FOLDER_ADD, payload: res.data })
// return res.data.id
// } catch (err) {
// addMsg(connectErrMsg(err, 'Не могу создать папку'))
// }
// }
// const fldrUpdate = async (folder) => {
// try {
// const res = await axios.put(`${URL}/prj/folder/${folder.id}/`, folder, config)
// const payload = state.folders.map((fldr) => (fldr.id !== res.data.id ? fldr : res.data))
// dispatch({ type: PRJ_FOLDER_REFRESH, payload })
// } catch (err) {
// addMsg(connectErrMsg(err, 'Не могу изменить папку'))
// }
// }
// const fldrRemove = async (folder_id) => {
// try {
// await axios.delete(`${URL}/prj/folder/${folder_id}/`, config)
// dispatch({ type: PRJ_FOLDER_REMOVE, payload: folder_id })
// } catch (err) {
// addMsg(connectErrMsg(err, 'Не могу удалить папку'))
// }
// }
// // FILES
// const fileUpdate = async (fileObj) => {
// try {
// const res = await axios.put(`${URL}/file/${fileObj.id}/`, fileObj, config)
// const payload = state.explorer.results.map((file) => (file.id !== res.data.id ? file : res.data))
// dispatch({ type: FOLDER_FILE_REFRESH, payload })
// } catch (err) {
// addMsg(connectErrMsg(err, 'Не могу изменить файл'))
// }
// }
// const fileRemove = async (file_id) => {
// try {
// await axios.delete(`${URL}/file/${file_id}/`, config)
// const payload = state.explorer.results.filter((file) => file.id !== file_id)
// dispatch({ type: FOLDER_FILE_REMOVE, payload: payload })
// } catch (err) {
// addMsg(connectErrMsg(err, 'Не могу удалить файл'))
// }
// }
// // UPLOAD & DOWNLOAD FILE
// const uploadLangFile = async (folderID, fileID, langID, file, setProgress) => {
// let formData = new FormData()
// formData.append('folder_id', folderID)
// formData.append('file_id', fileID)
// formData.append('lang_id', langID)
// // formData.append("name", file.name)
// formData.append('data', file)
// try {
// await axios.post(`${URL}/transfer/`, formData, {
// headers: { ...config.headers },
// onUploadProgress: (progressEvent) => {
// setProgress(Math.round((progressEvent.loaded / progressEvent.total) * 100))
// },
// })
// } catch (err) {
// addMsg(connectErrMsg(err, `Не удалось загрузить файл ${file.name}`))
// // throw new Error(`Не удалось загрузить файл ${file.name}`)
// }
// }
// const uploadFile = async (folderID, file, setProgress) => {
// let formData = new FormData()
// formData.append('data', file)
// formData.append('name', file.name)
// formData.append('folder_id', folderID)
// try {
// await axios.post(`${URL}/transfer/`, formData, {
// headers: { ...config.headers },
// onUploadProgress: (progressEvent) => {
// setProgress({
// [file.name]: Math.round((progressEvent.loaded / progressEvent.total) * 100),
// })
// },
// })
// } catch (err) {
// addMsg(connectErrMsg(err, `Не удалось загрузить файл ${file.name}`))
// // throw new Error(`Не удалось загрузить файл ${file.name}`)
// }
// }
// const downloadFile = async (translatedID, filename) => {
// try {
// // FIXME: Axios can't get Content-Disposition - filename
// const res = await axios.get(`${URL}/transfer/${translatedID}`, config)
// const obj_url = window.URL.createObjectURL(new Blob([res.data]))
// let tmp_elem = document.createElement('a')
// tmp_elem.href = obj_url
// tmp_elem.setAttribute('download', filename)
// document.body.appendChild(tmp_elem)
// tmp_elem.click()
// tmp_elem.remove()
// } catch (err) {
// addMsg(connectErrMsg(err, 'Не могу скачать файл'))
// }
// }
// // PROJECTS: File explorer
// const explList = async (save_id, folder_id, page, size) => {
// if (!save_id && !folder_id) dispatch({ type: EXPLORER_REFRESH, payload: {} })
// else {
// try {
// const res = await axios.get(`${URL}/file`, {
// ...config,
// params: { save_id, folder_id, page, size },
// })
// dispatch({ type: EXPLORER_REFRESH, payload: res.data })
// addMsg({ text: 'Получен список файлов', type: 'success' })
// } catch (err) {
// addMsg(connectErrMsg(err, 'Не могу получить список файлов'))
// }
// }
// }
// // TRANSLATES
// const transFileInfo = async (fID) => {
// try {
// const res = await axios.get(`${URL}/file/${fID}`, config)
// dispatch({ type: TRANSLATE_FILE_INFO, payload: res.data })
// // await transList(fID, page, size, same, noTrans) // FIXME: REMAKE
// } catch (err) {
// addMsg(connectErrMsg(err, 'Не могу получить файл'))
// }
// }
// const transList = async (file_id, page, size, no_trans, search_text = '') => {
// try {
// const res = await axios.get(`${URL}/marks`, {
// ...config,
// params: { file_id, page, size, no_trans, search_text },
// })
// dispatch({ type: TRANSLATE_PAGE_REFRESH, payload: res.data })
// } catch (err) {
// addMsg(connectErrMsg(err, 'Не могу получить текст файла'))
// }
// }
// const transLog = async (file_id, translate_id) => {
// // FIXME: Not correct way using (without reducer)
// try {
// const res = await axios.get(`${URL}/marks/changes/${translate_id}`, {
// ...config,
// params: { file_id },
// })
// return res.data
// } catch (err) {
// addMsg(connectErrMsg(err, 'Не могу получить историю изменений'))
// }
// }
// const transChange = async (trans_id, text, md5sum = '') => {
// const file_id = state.translates.id
// try {
// const res = await axios.post(`${URL}/marks/`, { file_id, trans_id, text, md5sum }, config)
// const payload = state.translates.results.map((transItem) => {
// if (md5sum) {
// if (transItem.md5sum !== md5sum) return transItem
// } else if (transItem.id !== trans_id) return transItem
// const haveTransBefore = transItem.translates_set.find((item) => item.id === trans_id)
// if (!haveTransBefore)
// return {
// ...transItem,
// translates_set: [...transItem.translates_set, res.data],
// }
// const newTransSet = transItem.translates_set.map((item) => {
// if (item.id !== trans_id) return item
// return res.data
// })
// return { ...transItem, translates_set: newTransSet }
// })
// dispatch({ type: TRANSLATE_CHANGE, payload })
// } catch (err) {
// addMsg(connectErrMsg(err, 'Не могу получить текст файла'))
// }
// }
// // PERMISSIONS
// const usersList = async (filterStr) => {
// // FIXME: Not correct way using (without reducer)
// try {
// const res = await axios.get(`${URL}/auth/users`, {
// ...config,
// params: { name: filterStr },
// })
// return res.data
// } catch (err) {
// addMsg(connectErrMsg(err, 'Ошибка получения списка пользователей'))
// // throw new Error("Ошибка получения списка пользователей")
// return []
// }
// }
// const permList = async (save_id) => {
// try {
// const res = await axios.get(`${URL}/prj/perm/`, {
// ...config,
// params: { save_id },
// })
// dispatch({ type: PRJ_PERMISSION_LIST, payload: res.data })
// } catch (err) {
// addMsg(connectErrMsg(err, 'Ошибка получения списка прав'))
// }
// }
// const permAdd = async (save_id, first_name, permission) => {
// try {
// const res = await axios.post(`${URL}/prj/perm/`, { save_id, first_name, permission }, config)
// let user = state.permissions.find((item) => item.first_name === first_name)
// if (!user) user = { first_name, prj_perms: [res.data] }
// else user.prj_perms = [...user.prj_perms, res.data]
// dispatch({ type: PRJ_PERMISSION_REFRESH, payload: user })
// } catch (err) {
// addMsg(connectErrMsg(err, 'Не могу добавить права'))
// }
// }
// const permRemove = async (save_id, first_name, permission) => {
// let user = state.permissions.find((item) => item.first_name === first_name)
// if (!user) return addMsg({ text: 'У юзера нет прав к игре' })
// const perm = user.prj_perms.find((item) => item.permission === permission)
// if (!perm) return addMsg({ text: 'У юзера нет таких прав' })
// try {
// await axios.delete(`${URL}/prj/perm/${perm.id}/`, config)
// user.prj_perms = user.prj_perms.filter((item) => item.permission !== permission)
// dispatch({ type: PRJ_PERMISSION_REFRESH, payload: user })
// } catch (err) {
// addMsg(connectErrMsg(err, 'Ошибка при удалении прав'))
// }
// }
// // REPOSITORY
// const repoCheck = async (save_id, folder_id) => {
// try {
// const res = await axios.get(`${URL}/prj/folder/${folder_id}`, {
// ...config,
// params: { save_id },
// })
// if (res.data.repo_status !== null) {
// const payload = state.folders.map((fldr) => (fldr.id !== res.data.id ? fldr : res.data))
// dispatch({ type: PRJ_FOLDER_REFRESH, payload })
// return true
// }
// return false
// } catch (err) {
// addMsg(connectErrMsg(err, 'Информация о репозитории не получена'))
// }
// }
// const repoGet = async (save_id, folder_id) => {
// dispatch({ type: REPOSITORY_REFRESH, payload: {} })
// try {
// const res = await axios.get(`${URL}/repo/${folder_id}`, {
// ...config,
// params: { save_id },
// })
// console.log('UPDATE REPO TO', res.data)
// dispatch({ type: REPOSITORY_REFRESH, payload: res.data })
// } catch (err) {
// addMsg(connectErrMsg(err, 'Информация о репозитории не получена'))
// }
// }
// const repoAccess = async (save_id, folder_id, type, code) => {
// try {
// const res = await axios.put(`${URL}/repo/${folder_id}/`, { save_id, type, code }, config)
// dispatch({ type: REPOSITORY_REFRESH, payload: res.data })
// } catch (err) {
// addMsg(connectErrMsg(err, 'Ошибка изменения доступа к репозиторию'))
// }
// }
