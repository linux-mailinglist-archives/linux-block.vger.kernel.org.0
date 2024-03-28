Return-Path: <linux-block+bounces-5104-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA1E88C312
	for <lists+linux-block@lfdr.de>; Tue, 26 Mar 2024 14:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77AC2B234BE
	for <lists+linux-block@lfdr.de>; Tue, 26 Mar 2024 13:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C82E6D1CE;
	Tue, 26 Mar 2024 13:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yPxz7SiA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zsvbperu";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yPxz7SiA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zsvbperu"
X-Original-To: linux-block@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6E770CBA
	for <linux-block@vger.kernel.org>; Tue, 26 Mar 2024 13:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711458849; cv=none; b=PZLWq55tlQ/Jy3wfIRruQ+iWOLz1W1XpuF1YWqUBktAbKJpteqQjNj8FOocCkGg9olGii0K4HM6StFZiCyK7Zom+vpTPiVySQT+6z0poiJZGpH6JvLhFBGCmypXsPG3Pr4tdVU/FcKRMV+JjzYMHjAZDz3VywF0uOy8Qpqcpxlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711458849; c=relaxed/simple;
	bh=0PDAGd7UmpSs2J1BEP+a3QkiOlTONyfRMaLja9bzmHY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=alac3cxng8x/uilfOOGkSjnKLFW7eVsWvCsOyGf7mb+9XH8HDkPSFNMBEUQie0qshZXpqdgG8G4iexYHY7xxEA9EKoqpn4VLLzPXEAS/Xxi5lw2kscKc/PbQh0ofGOJYT4hwhhgo62udziyZVkRSERgXQ5RcKJm/IN0YtrMAxi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yPxz7SiA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zsvbperu; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yPxz7SiA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zsvbperu; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7C90C373D7;
	Tue, 26 Mar 2024 13:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711458845; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=m1GAW7oNEUE9NMKiHlDH6v9szzT0RFRzVYCBWZqNEDA=;
	b=yPxz7SiAaIKdRwxfufDED/hZcxzhe8MtCzvncRNuHP0Hl2eoReMLUT4lSM30Ybn89gNy46
	yRjBVhutzS4OQADQl8DevFwP8trapjnibgREdnl49VA4IPNaXWOYag4Veyjr01YUJV3m/B
	57lKrQHo4vrgp31HnZecjXzFZcDI3cU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711458845;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=m1GAW7oNEUE9NMKiHlDH6v9szzT0RFRzVYCBWZqNEDA=;
	b=zsvbperuP8MUbrFgBjJkEzVqnty7v9I6ZXevuSUKmaRNjFUA3w5Lk8V/DSFPQUGQa2O3Ux
	5woX5roEAaRCFnDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711458845; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=m1GAW7oNEUE9NMKiHlDH6v9szzT0RFRzVYCBWZqNEDA=;
	b=yPxz7SiAaIKdRwxfufDED/hZcxzhe8MtCzvncRNuHP0Hl2eoReMLUT4lSM30Ybn89gNy46
	yRjBVhutzS4OQADQl8DevFwP8trapjnibgREdnl49VA4IPNaXWOYag4Veyjr01YUJV3m/B
	57lKrQHo4vrgp31HnZecjXzFZcDI3cU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711458845;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=m1GAW7oNEUE9NMKiHlDH6v9szzT0RFRzVYCBWZqNEDA=;
	b=zsvbperuP8MUbrFgBjJkEzVqnty7v9I6ZXevuSUKmaRNjFUA3w5Lk8V/DSFPQUGQa2O3Ux
	5woX5roEAaRCFnDQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 6A72913587;
	Tue, 26 Mar 2024 13:14:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id sqKKGB3KAmb5NgAAn2gu4w
	(envelope-from <dwagner@suse.de>); Tue, 26 Mar 2024 13:14:05 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v3 00/20]  refactoring and various cleanups/fixes
Date: Tue, 26 Mar 2024 14:13:42 +0100
Message-ID: <20240326131402.5092-1-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=yPxz7SiA;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=zsvbperu
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.49 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: 0.49
X-Rspamd-Queue-Id: 7C90C373D7
X-Spam-Flag: NO

I've updated the passthru tests in the same way as the rest of the fabric tests.

changes:
 v3:
  - streamlined passthru tests according the rest of the fabric tests
  
 v2:
  - addressed 'make check' errors
  - squashed 'nvme/rc: remove correct port from target'
    into 'nvme/rc: add nqn/uuid args to target setup/cleanup helper'
  - reordered patches
  - added 'nvme: drop default trtype argument for _nvmet_passthru_target_connect'
  - https://lore.kernel.org/linux-nvme/20240322135015.14712-1-dwagner@suse.de/

 v1:
   - https://lore.kernel.org/linux-nvme/20240321094727.6503-1-dwagner@suse.de/

Daniel Wagner (20):
  nvme/rc: silence error on module unload for fc
  nvme/rc: silence fcloop cleanup failures
  nvme/rc: log error if stale configuration is found
  common/xfs: propagate errors from _xfs_run_fio_verify_io
  nvme/{012,013,035}: check return value of _xfs_run_fio_verify_io
  nvme/rc: use long command line option for nvme
  nvme/{014,015,018,019,020,023,024,026,045,046}: use long command line
    option for nvme
  nvme/rc: connect subsys only support long options
  nvme/rc: add nqn/uuid args to target setup/cleanup helper
  nvme/rc: remove unused connect options
  nvme/rc: do not cleanup external managed loop device
  nvme/031: do not open code target setup/cleanup
  nvme: drop default trtype argument for _nvmet_connect_subsys
  nvme: drop default trtype argument for _nvmet_passthru_target_connect
  nvme: drop default subsysnqn argument from
    _nvme_{connect|disconnect}_subsys
  nvme: drop default subsysnqn argument from
    _nvme_passthru_target_{setup|cleanup}
  nvme: drop default subsysnqn argument from
    _nvmet_passthru_target_connect
  nvme/{041,042,043,044,045,048}: do not pass default host{nqn|id} to
    _nvme_connect_subsys
  nvme: don't assume namespace id
  nvme/028: drop unused nvmedev

 common/xfs     |   9 +-
 tests/nvme/003 |   4 +-
 tests/nvme/004 |   5 +-
 tests/nvme/005 |   2 +-
 tests/nvme/008 |   4 +-
 tests/nvme/009 |   4 +-
 tests/nvme/010 |  11 ++-
 tests/nvme/011 |  11 ++-
 tests/nvme/012 |  13 +--
 tests/nvme/013 |  13 +--
 tests/nvme/014 |  17 ++--
 tests/nvme/015 |  17 ++--
 tests/nvme/018 |  20 ++---
 tests/nvme/019 |  13 ++-
 tests/nvme/020 |  12 +--
 tests/nvme/021 |  11 ++-
 tests/nvme/022 |   4 +-
 tests/nvme/023 |  11 ++-
 tests/nvme/024 |  12 +--
 tests/nvme/025 |  11 ++-
 tests/nvme/026 |  11 ++-
 tests/nvme/027 |   4 +-
 tests/nvme/028 |   9 +-
 tests/nvme/029 |  11 +--
 tests/nvme/031 |  16 ++--
 tests/nvme/033 |   8 +-
 tests/nvme/034 |   8 +-
 tests/nvme/035 |  12 +--
 tests/nvme/036 |   8 +-
 tests/nvme/037 |  10 ++-
 tests/nvme/040 |   6 +-
 tests/nvme/041 |  13 +--
 tests/nvme/042 |  14 +--
 tests/nvme/043 |  14 +--
 tests/nvme/044 |  28 ++----
 tests/nvme/045 |  17 ++--
 tests/nvme/046 |   7 +-
 tests/nvme/047 |  16 ++--
 tests/nvme/048 |   9 +-
 tests/nvme/rc  | 232 ++++++++++++++++++++++++++++++++++---------------
 40 files changed, 357 insertions(+), 300 deletions(-)

-- 
2.44.0


